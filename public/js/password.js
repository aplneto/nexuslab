function confirmPassword() {
    let newPassword = document.getElementById("newPassword").value;
    let newPasswordConfirmation = document.getElementById("newPasswordConfirmation").value;

    if (newPassword != newPasswordConfirmation) {
        document.getElementById("error").innerHTML = "Nova senha e confirmação devem ser iguais!";
        return false;
    }
    return true;
}

function verifyPassword() {
    let passwrdRegex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,32}$/;
    let newPassword = document.getElementById("newPassword").value;

    if (!passwrdRegex.test(newPassword)) {
        document.getElementById("error").innerHTML = "Sua nova senha deve conter entre 8 e 32 caracteres, sendo pelo menos: 1 letra maiúscula, 1 letra minúscula, 1 digito e 1 caractere especial";
        return false;
    }
    return true;
}