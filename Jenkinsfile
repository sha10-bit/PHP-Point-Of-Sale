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
                    cp application/config/database.php.tmpl application/config/database.php
                    sed -i "s/'localhost'/'${DB_HOST}'/" application/config/database.php
                    sed -i "s/'root'/'${DB_USER}'/" application/config/database.php
                    sed -i "s/'password'/'${DB_PASS}'/" application/config/database.php
                    sed -i "s/'database'/'${DB_NAME}'/" application/config/database.php
                '''
            }
        }

        stage('Verify') {
            steps {
                echo "Checking PHP syntax"
                sh 'php -l application/config/database.php'
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying application"
                sh '''
                    sudo mkdir -p /var/www/html/pos
                    sudo cp -r . /var/www/html/pos/
                    sudo chown -R www-data:www-data /var/www/html/pos
                    sudo chmod -R 755 /var/www/html/pos
                    sudo chmod -R 775 /var/www/html/pos/application/cache
                    sudo chmod -R 775 /var/www/html/pos/application/logs
                '''
            }
        }
    }

    post {
        always {
            echo "Build finished"
        }
    }
}
