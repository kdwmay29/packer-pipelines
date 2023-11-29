// This Jenkinsfile defines a declarative pipeline
pipeline {
    // Specifies that this pipeline can run on any available agent
    agent any

    // Defines the sequence of stages that will be executed
    stages {
        // This stage checks out the source code from the SCM (Source Code Management) system
        stage('Checkout') {
            steps {
                // This command checks out the source code from the SCM into the Jenkins workspace
                checkout scm
            }
        }

        // This stage validates the Packer template
        stage('Validate Packer Template') {
            steps {
                script {
                    // This command validates the Packer HCL (HashiCorp Configuration Language) template using the provided variable files.  Ensure these file names are correct for your setup.
                    sh "packer validate /root/packertest/al2023.pkr.hcl"
                }
            }
        }

        // This stage builds a VMWare image using Packer
        stage('Build VMWare Image') {
            when {
                // This condition ensures that this stage will only run if the previous 'Validate Packer Template' stage succeeded
                expression { currentBuild.resultIsBetterOrEqualTo('SUCCESS') }
            }
            steps {
                script {
                    // This command builds a VMWare image using Packer with the provided variable files
                    // It will forcefully build the image even if it exists and will prompt for action on any errors
                    // Ensure these file names are correct for your setup
                    sh "packer build /root/packertest/al2023.pkr.hcl"
                }
            }
        }
    }

    // Defines actions to be executed after the stages, regardless of their outcome
    post {
        // This will always archive any .log files in the workspace, even if there are none
        always {
            archiveArtifacts artifacts: '**/*.log', allowEmptyArchive: true
        }
        // If any stage failed, this will print an error message
        failure {
            echo "The build failed. Please check the logs."
        }
    }
}
