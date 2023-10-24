<?php
require("inc_db.php");
$org_id = $_GET["org_id"];


$sql = "SELECT * FROM organizations WHERE id = $org_id";

$rs = mysqli_query($cn, $sql);
$org = mysqli_fetch_assoc($rs);
?>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Lift RMS</title>
    <link rel="stylesheet" href="style1.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="apple-touch-icon" sizes="180x180" href="assets/images/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="assets/images/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="assets/images/favicon-16x16.png">
    <link rel="manifest" href="/site.webmanifest">
</head>

<body>
    <header>
        <div class="navbar">
            <div class="navbar-2">
                <div class="logo"><img src="assets\images\logo company\icon_yellow.svg" alt=""></a></div>
                <div class="toggle_btn">
                    <i class="fa-solid fa-bars"></i>
                </div>
                <p>Asia Schneider</p>
                <ul class="links">
                    <li><a href="orgs.php"><i class="fa-solid fa-house"></i> &nbsp;HOME</a></li>
                    <li><a href="summary/summary.php"> &nbsp;SUMMARY</a></li>
                    <li><a href="add_org.php"><i class="fa-solid fa-file-circle-plus"></i> &nbsp;ADD</a></li>
                    <!-- <div class="dropdown">
                        <button class="dropbtn">ORGANIZATION &nbsp;
                            <i class="fa fa-caret-down"></i>
                        </button>
                        <div class="dropdown-content">
                            <a href="../orgs.php">HOME ORGANIZATION</a>
                            <a href="../add_org.php">ADD_ORGANIZATION</a>
                            <a href="../edit_org.php">EDIT_ORGANIZATION</a>
                        </div>
                    </div> -->
                </ul>
                <div class="wrap">
                    <form action="" autocomplete="on">
                        <input class="search" id="search" name="search" type="text" placeholder="Search...">
                        <input class="search" id="search_submit" value="Rechercher" type="submit">
                    </form>
                </div>
                <div><i class="fa-solid fa-user"></i></div>
            </div>
        </div>
    </header>

    <main>
        <div class="main-content" id="content">
            <p>Organization</p>
            <form action="submit_edit_org.php" method="post" id="form_head">

                <div class="form-edit-add">
                    <input class="orgs-id" type="hidden" name="id" value="<?php print($org["id"]); ?>"><br>
                    <label for="">Name<span class="span1">*</span></label><br>

                    <input class="input-form" id="edit_org" type="text" name="org_name" size="30"
                        value="<?php print($org["org_name"]); ?>"><br>

                    <div class="btn"><input class="btn-submit" type="submit"></div>
                </div>
    </main>
    <script src="script.js"></script>
</body>

</html>