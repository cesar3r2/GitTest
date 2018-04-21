<?php

// PHP Grid database connection settings, Only need to update these in new project

define("PHPGRID_DBTYPE","postgres"); // mysql,oci8(for oracle),mssql,postgres,sybase
define("PHPGRID_DBHOST","localhost");
define("PHPGRID_DBUSER","admin");
define("PHPGRID_DBPASS","(_admin_)");
define("PHPGRID_DBNAME","parley360");

// Basepath for lib
define("PHPGRID_LIBPATH",dirname(__FILE__).DIRECTORY_SEPARATOR."lib".DIRECTORY_SEPARATOR);