<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <link rel="stylesheet" type="text/css" href="css/new-session.css">
    <title>Eyes Project - Nouvelle session</title>
</head>

<body>
    <div class='barre'>
        <picture class='picture picture--logo'>
            <img class='image image--logo' src="img/logo-eyesproject-small.jpg" alt="Logo Eyes Project">
        </picture>
    </div>
    <div class='main'>
        <div class='formulaire'>
            <form action="/api/form">
                <fieldset>
                    <div class='formulaire__row'>
                        <div class='formulaire__element'>
                            <label class='formulaire__label' for='form_email'>Email</label>
                            <input class='formulaire__input' id='form_email' name='email' type="email" required>
                        </div>
                    </div>
                    <div class='formulaire__row'>
                        <div class='formulaire__element'>
                            <label class='formulaire__label' for='form_firstname'>Prenom</label>
                            <input class='formulaire__input' id='form_firstname' name='firstname' type="text" required>
                        </div>
                    </div>
                    <div class='formulaire__row'>
                        <div class='formulaire__element'>
                            <label class='formulaire__label' for='form_lastname'>Nom</label>
                            <input class='formulaire__input' id='form_lastname' name='lastname' type="text" required>
                        </div>
                    </div>

                    <div class='formulaire__row'>
                        <div class='formulaire__element'>
                            <label class='formulaire__label' for='form_age'>Age</label>
                            <input class='formulaire__input' id='form_age' name='age' type="text" required>
                        </div>
                    </div>
                    <div class='formulaire__row'>
                        <label class='formulaire__label' for='form_sex'>Sexe</label>
                        <div class='formulaire__element formulaire__element--choice'>
                            <input class='formulaire__input formulaire__input--radio' id='form_male' name='sex' type="radio" checked>
                            <label class='formulaire__label' for='form_male'>Masculin</label>
                        </div>
                        <div class='formulaire__element formulaire__element--choice'>
                            <input class='formulaire__input formulaire__input--radio' id='form_female' name='sex' type="radio">
                            <label class='formulaire__label' for='form_female'>Feminin</label>
                        </div>
                    </div>
                    <button type="submit">Envoyer</button>
                </fieldset>
            </form>
        </div>
    </div>
</body>
<script src="//cdnjs.cloudflare.com/ajax/libs/validate.js/0.13.1/validate.min.js"></script>
<script src="/js/send-form.js"></script>

</html>