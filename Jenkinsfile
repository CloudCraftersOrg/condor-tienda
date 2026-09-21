@Library('condor-shared') _

pipeline {
    agent any

    stages {
        stage('Test') {
            steps {
                sh '''
                    python3 -m venv .venv
                    . .venv/bin/activate
                    pip install -r requirements.txt -r requirements-dev.txt
                    pytest
                '''
            }
        }
        stage('Approve') {
            steps {
                input message: 'Deploy condor-tienda to production?'
            }
        }
        stage('Deploy') {
            steps {
                sh 'rm -rf .venv __pycache__ .pytest_cache'
                condorZipWorkspaceBundle()
                condorPublishAndDeploy(
                    bucket: 'condor-tienda-artifactbucket-bvqboejicngo',
                    applicationName: 'condor-tienda',
                    deploymentGroupName: 'condor-tienda-prod',
                )
            }
        }
    }
}
