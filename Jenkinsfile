pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                docker compose down

                # Ensure workspace files are used
                cp -r . /var/lib/jenkins/workspace/pos-deploy/

                docker compose build
                docker compose up -d
                '''
            }
        }

    }
}
