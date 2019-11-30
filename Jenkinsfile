pipeline {
    agent {
        label 'dory'
    }
    options { 
        disableConcurrentBuilds()
    }
    triggers {
        pollSCM('* * * * *')
        cron('@weekly')
    }
    parameters {
        string(name: 'GPF_BRANCH', defaultValue: "master", description: 'gpf git branch to package')
        string(name: 'GPFJS_BRANCH', defaultValue: "master", description: 'gpfjs git branch to package')
    }    
    environment {
        GPF_BRANCH="master"
        GPFJS_BRANCH="master"
        GPF_VERSION="3.0.0dev"
    }
    stages {
        stage ('Start') {
            steps {
                slackSend (
                    color: '#FFFF00',
                    message: "STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' ${env.BUILD_URL}"
                )
            }
        }

        stage('clean') {
            steps {
                sh '''
                    rm -rf builds
                    rm -rf gpf
                    rm -rf gpfjs
                '''
            }
        }

        stage('gpf & gpfjs source') {
            steps {
                sh '''
                    ./jenkins_source.sh
                '''
            }
        }

        stage('gpfjs build') {
            steps {
                sh '''
                    ./jenkins_build_gpfjs.sh
                '''
            }
        }

        stage('django gpfjs build') {
            steps {
                sh '''
                    ./jenkins_django_gpfjs.sh
                '''
            }
        }

        stage('package gpf') {
            steps {
                sh '''
                    ./jenkins_gpf_package.sh
                '''
            }
        }

        // stage('tag repos') {
        //     steps {
        //         sh '''
        //             ./jenkins_tag.sh
        //         '''
        //     }
        // }

    }
    post {
        success {
            archiveArtifacts artifacts: 'builds/*.tar.gz'

            slackSend (
                color: '#00FF00',
                message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' ${env.BUILD_URL}"
            )
        }
        failure {
            slackSend (
                color: '#FF0000',
                message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' ${env.BUILD_URL}"
            )
        }
    }
}

