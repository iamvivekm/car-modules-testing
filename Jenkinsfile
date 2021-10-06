node {
    git branch: 'main', changelog: false, credentialsId: '3d74508b-cad7-4688-b0aa-6e0c3a300d72', url: 'https://github.com/iamvivekm/car-modules-testing.git'

    stage "Checkout the code"
    checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: '3d74508b-cad7-4688-b0aa-6e0c3a300d72', url: 'https://github.com/iamvivekm/car-modules-testing.git']]])

    stage "Trigger the maven profile"
    withMaven {
        bat 'mvn clean veriry'
    }

    // Archive the build output artifacts.
    archiveArtifacts artifacts: 'target/cucumber-html-reports', excludes: 'output/*.md'
}