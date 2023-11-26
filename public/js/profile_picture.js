window.addEventListener('load', () => {
    
    document.getElementById('pictureButton').addEventListener('click', () => {
        document.getElementById('pictureInput').click();
    })

    document.getElementById('pictureInput').addEventListener('change', () => {
        document.getElementById('pictureUploadForm').submit();
    })
})