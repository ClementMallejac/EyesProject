<?php
require_once $_SERVER['DOCUMENT_ROOT'] . "/utils/sex.constants.php";

// errors
const ERROR_EMPTY_VALUE = 1;
const ERROR_WRONG_FORMAT = 2;
const ERROR_DATABASE = 3;
const ERROR_DATABASE_BEFORE_PERSONNE = 4;
const ERROR_DATABASE_AFTER_PERSONNE = 5;
const ERROR_DATABASE_SESSION_CREATE = 6;
const ERROR_PHP_SESSION_CREATE = 7;


// cleaning POST data
$data = [];

$post = json_decode(file_get_contents('php://input'), true);


// required fields 
$required = ['email', 'firstname', 'lastname', 'age', 'sex'];

if (isset($post)) {
    foreach ($required as $rq)
    if (!key_exists($rq, $post) || strlen($post[$rq]) === 0)
    exit(json_encode(['error' => ERROR_EMPTY_VALUE, 'message' => "{$rq} is empty"]));
}


// test du nom
if (!is_string($post['lastname']) || strlen($post['lastname']) === 0)
exit(json_encode(['error' => ERROR_EMPTY_VALUE, 'message' => "lastname is an empty string"]));

// test du prenom
if (!is_string($post['firstname']) || strlen($post['firstname']) === 0)
exit(json_encode(['error' => ERROR_EMPTY_VALUE, 'message' => "firstname is an empty string"]));

// test de l'age
if (!is_int($post['age']) || intval($post['age']) < 0 || intval($post['age']) > 140)
exit(json_encode(['error' => ERROR_WRONG_FORMAT, 'message' => "age is not a positive and valid integer"]));

// test de l'email
if (filter_var($post['email'], FILTER_VALIDATE_EMAIL) == false)
exit(json_encode(['error' => ERROR_WRONG_FORMAT, 'message' => "sex is not a boolean"]));



// email
$data[':emailPersonne'] = $post['email'];

// nom
$data[':nomPersonne'] = $post['lastname'];

// prenom
$data[':prenomPersonne'] = $post['firstname'];

// sex
$data[':sexePersonne'] =  $post['sex'] == Sex::FEMALE ? '1' : '0';

// age
$data[':agePersonne'] = $post['age'];



// send to database

try {
    $pdo = new PDO('mysql:dbname=EyesProject;host=db', 'ep_user', 'ep_password');
    $pdo->beginTransaction();
} catch (PDOException $e) {
    exit(json_encode(['error' => ERROR_DATABASE, 'message' => "Connection to database failed"]));
}

// is user already in Personne database table ?
// counts the number of Personne in DB with the specified email
$count = ($r = $pdo->prepare('SELECT COUNT(emailPersonne) FROM Personne WHERE emailPersonne = :emailPersonne')->execute([':emailPersonne' => $data[':emailPersonne']]))? $r[0] : 0;
$sql = null;
$is_update = false;

try {
    if ($count > 0) {
        // Personne exists in DB => update the entry
        $sql = 'UPDATE Personne 
            SET nomPersonne = :nomPersonne, 
                prenomPersonne = :prenomPersonne, 
                sexePersonne = :sexePersonne,
                agePersonne = :agePersonne
            WHERE emailPersonne = :emailPersonne';

$is_update = true;
} else {
    // Personne doesnt exist in DB => insert the entry
    $sql = 'INSERT INTO Personne (emailPersonne, nomPersonne, prenomPersonne, sexePersonne, agePersonne) 
            VALUES (:emailPersonne, :nomPersonne, :prenomPersonne, :sexePersonne, :agePersonne)';
    }

    $stmt = $pdo->prepare($sql);
    if ($stmt->execute($data) === false)
        throw new PDOException();

    $answer = ['error' => 0, 'message' => $is_update ? 'Personne successfully updated in database' : 'Personne successfully inserted in database'];
} catch (PDOException $e) {
    exit(json_encode(['error' => ERROR_DATABASE_BEFORE_PERSONNE, 'message' => $id_update ? "Failed to update Personne in database " : "Failed to insert Personne in database"]));
}

try {
    // get last Personne ID
    $stmt = $pdo->prepare('SELECT idPersonne FROM Personne WHERE emailPersonne = :emailPersonne');
    $stmt->execute([":emailPersonne" => $data[":emailPersonne"]]);
    $idPersonne = $stmt->fetch()['idPersonne'];
    $answer['idPersonne'] = $idPersonne;
} catch (PDOException $e) {
    exit(json_encode(['error' => ERROR_DATABASE_AFTER_PERSONNE, 'message' => "Failed to get last idPersonne"]));
}

// creates a new Session bound to the user in Database
try {
    $sql = 'INSERT INTO Session (idPersonne) VALUES (:idPersonne)';

    // creates a session in database linked to the Personne
    $session_id = $pdo->prepare($sql)->execute([":idPersonne" => $idPersonne]);

    // request failed
    if ($session_id === false) throw new PDOException();

    // PHP Session fails to start
    if (session_start() === false) throw new Exception();

    // saves Personne id in PHP Session
    $_SESSION["personne"] = $idPersonne;

    // saves Database Session id in PHP Session
    $_SESSION['id'] = $session_id;
    $answer['idSession'] = $session_id;
} catch (PDOException $e) {
    exit(json_encode(['error' => ERROR_DATABASE_SESSION_CREATE, 'message' => "Failed to create new session in database"]));
} catch (Exception $e) {
    exit(json_encode(['error' => ERROR_PHP_SESSION_CREATE, 'message' => "Failed to create new session in PHP"]));
}

//OK, tout fonctionne
$pdo->commit();
exit(json_encode(['error' => false, 'data' => $answer]));