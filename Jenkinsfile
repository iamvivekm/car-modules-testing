pipeline {
    agent none
    git branch: 'main', changelog: false, credentialsId: '3d74508b-cad7-4688-b0aa-6e0c3a300d72', url: 'https://github.com/iamvivekm/car-modules-testing.git'
    stages {
        stage("Checkout the code") {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: '3d74508b-cad7-4688-b0aa-6e0c3a300d72', url: 'https://github.com/iamvivekm/car-modules-testing.git']]])
            }
        }
        stage("Trigger the maven profile") {
            steps {
                withMaven {
                        bat 'mvn clean verify'
                }
            }
        }
    }
    post {
        always {
            publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'target/cucumber-html-reports', reportFiles: 'overview-features.html', reportName: 'Smoke Test Report', reportTitles: ''])
        }
    }
}
