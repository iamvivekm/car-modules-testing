pipeline {
    agent any
    stages {
        stage("Checkout the code") {
            steps {
                git branch: 'main', changelog: false, credentialsId: '3d74508b-cad7-4688-b0aa-6e0c3a300d72', url: 'https://github.com/iamvivekm/car-modules-testing.git'
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: '3d74508b-cad7-4688-b0aa-6e0c3a300d72', url: 'https://github.com/iamvivekm/car-modules-testing.git']]])
            }
        }
        stage("Trigger the maven profile") {
            steps {
                withMaven {
                        bat 'mvn "-Dkarate.options=--tags @%tagName%" clean verify -P%profile%'
                }
            }
        }
    }
    post {
        always {
            publishHTML([allowMissing: false, alwaysLinkToLastBuild: true, keepAll: true, reportDir: 'target/cucumber-html-reports', reportFiles: 'overview-features.html', reportName: 'Smoke Test Report', reportTitles: ''])
        }
    }
}
