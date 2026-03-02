pipeline {
    agent any

    environment {
        DB_HOST = 'localhost'
        DB_USER = 'pos_user'
        DB_PASS = 'pos123456'
        DB_NAME = 'pos_app'
        APP_PATH = '/var/www/html/pos'
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Getting code from Git"
                checkout scm
            }
        }

        stage('Create Database Config') {
            steps {
                echo "Creating database.php file"
                sh '''
                    cat > application/config/database.php << 'DBCONFIG'
<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

$active_group = "default";
$active_record = TRUE;

$db['default']['hostname'] = "localhost";
$db['default']['username'] = "pos_user";
$db['default']['password'] = "pos123456";
$db['default']['database'] = "pos_app";
$db['default']['dbdriver'] = "mysql";
$db['default']['dbprefix'] = "phppos_";
$db['default']['pconnect'] = FALSE;
$db['default']['db_debug'] = FALSE;
$db['default']['cache_on'] = FALSE;
$db['default']['cachedir'] = "";
$db['default']['char_set'] = "utf8";
$db['default']['dbcollat'] = "utf8_general_ci";
DBCONFIG
                '''
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying application"
                sh '''
                    sudo mkdir -p /var/www/html/pos
                    sudo mkdir -p /var/www/html/pos/application/cache
                    sudo mkdir -p /var/www/html/pos/application/logs
                    sudo cp -r . /var/www/html/pos/
                    sudo chown -R www-data:www-data /var/www/html/pos
                    sudo chmod -R 755 /var/www/html/pos
                '''
            }
        }
    }

    post {
        success {
            echo "BUILD SUCCESSFUL"
        }
        failure {
            echo "BUILD FAILED"
        }
    }
}
