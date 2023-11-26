window.addEventListener('load', () => {
    let dropdown = document.getElementById('avisos-dropdown');

    dropdown.addEventListener('click', (ev) => {
        ev.stopPropagation();
        dropdown.classList.toggle('is-active');
    });
})