document.addEventListener("DOMContentLoaded", e => {
    // element du formulaire
    const formElement = document.getElementsByTagName("form")[0];
    formElement.addEventListener("submit", e => submitFormHandler(e, formElement));

    console.log('k');

});

/**
 * Handler of the submit
 * @param {Event} event 
 * @param {HTMLElement} form the form submitting
 */
function submitFormHandler(event, form) {
    // prevents the html submission
    event.preventDefault();

    // gets correct data from the form
    const data = getData();

    // sends request to the API (/api/form)
    // fetch answer (in JSON)
    fetch(form.action, {
            method: "POST",
            body: JSON.stringify(data),
            headers: {
                'Content-Type': 'application/json'
            }
        })
        .then(json => json.json())
        .then(answer => {
            if (answer.error !== false) {
                alert("ERROR: " + answer.message);
            } else {
                doSuccess(answer.data);
            }
        })
        .catch(error => {
            console.log(error);
            // error message: request failed
            alert("Impossible de contacter le serveur. sddwConnexion active ?");
        });
}

/**
 * Handles successful API request to /api/form
 * @param {Object} data contains { personne: (Personne.id), id: (Session.id) }
 */
function doSuccess(data) {
    // redirect to /doing
    window.location.replace('/session');

}


function getData() {
    // gets data from form inputs
    const rawData = {
        "email": document.getElementById("form_email").value,
        "firstname": validate.capitalize(document.getElementById("form_firstname").value),
        "lastname": validate.capitalize(document.getElementById("form_lastname").value),
        "age": parseInt(document.getElementById("form_age").value),
        "sex": document.getElementById("form_female").checked ? 1 : 0,
    };

    // applied constraints to data inputs
    const constraints = {
        email: {
            presence: true,
            email: true,
        },
        firstname: {
            presence: true,
        },
        lastname: {
            presence: true,
        },
        age: {
            presence: true,
            numericality: {
                onlyInteger: true,
                greaterThan: 8,
                lessThanOrEqualTo: 150,
            }
        },
        sex: {
            presence: true,
            type: "boolean",
        },
    };


    return validate.cleanAttributes(rawData, constraints);
}