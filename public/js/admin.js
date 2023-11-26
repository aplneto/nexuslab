function deleteUserRequest(id) {
    if (window.confirm("Tem certeza que deseja deletar esse usuário?")) {
        let xhr = new XMLHttpRequest();

        xhr.open('DELETE', "/user/" + id);
        xhr.onload = () => {
            location.reload()
        }
    
        xhr.send();
    }
}

window.addEventListener('load', () => {
    let currentActiveElementId = window.location.pathname.split('/').slice(-1)[0];
    let currentActiveElement = document.getElementById(currentActiveElementId);
    if (currentActiveElement !== null) {
        currentActiveElement.classList.add('is-active');
    } 

})