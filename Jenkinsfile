cd /PHP-Point-Of-Sale


cp /mnt/user-data/outputs/Jenkinsfile-SIMPLE Jenkinsfile


cat > Jenkinsfile << 'EOF'
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
                echo "Checking out code..."
                checkout scm
            }
        }

        stage('Create Database Config') {
            steps {
                echo "Creating database configuration file..."
                sh '''
                    cp application/config/database.php.tmpl application/config/database.php
                    sed -i "s/'localhost'/'${DB_HOST}'/" application/config/database.php
                    sed -i "s/'root'/'${DB_USER}'/" application/config/database.php
                    sed -i "s/'password'/'${DB_PASS}'/" application/config/database.php
                    sed -i "s/'database'/'${DB_NAME}'/" application/config/database.php
                    echo "✓ Configuration file created"
                '''
            }
        }

        stage('Verify Configuration') {
            steps {
                sh 'php -l application/config/database.php'
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    sudo mkdir -p /var/www/html/pos
                    sudo cp -r . /var/www/html/pos/
                    sudo chown -R www-data:www-data /var/www/html/pos
                    sudo chmod -R 755 /var/www/html/pos
                '''
            }
        }
    }

    post {
        success {
            echo " BUILD SUCCESSFUL! Access: http://localhost/pos"
        }
        failure {
            echo " BUILD FAILED!"
        }
    }
}
EOF
