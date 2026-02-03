<?php
$target_dir = "uploads/";
$target_file = $target_dir . basename($_FILES["fileToUpload"]["name"]);

// FAILLE : Aucune vérification de l'extension du fichier !
if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
    echo "Le fichier ". basename( $_FILES["fileToUpload"]["name"]). " a été uploadé.";
    echo "<br>Lien : <a href='$target_file'>$target_file</a>";
} else {
    echo "Désolé, une erreur est survenue.";
}
?>
