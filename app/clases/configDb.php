<?php
	global $config_db_user ;     // Usuario
	global $config_db_password;  // Clave
	global $config_db_port;      // Puerto -> aun no se aplica
	global $config_db;           // Servicio de Base de Datos ->aun no se aplica
	global $config_db_ip;        // Servidor de Base de Datos -> aun no se aplica
	global $config_db_debug;
	global $config_db_driver;
	global $config_absolute_path;
	
	//creacion del perfil
	include_once($config_absolute_path."/adodb5/adodb.inc.php");
	$this->_perfil1 =  ADONewConnection($config_db_driver);
	$this->_perfil1->debug = $config_db_debug;
	$this->_perfil1->NLS_DATE_FORMAT =  'DD/MM/YYYY';
	$this->_perfil1->PConnect($config_db_ip, $config_db_user, $config_db_password, $config_db);
	$this->_perfil1->SetFetchMode(ADODB_FETCH_ASSOC); // ADODB_FETCH_NUM
?>