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
        GPF_BRANCH="$params.GPF_BRANCH"
        GPFJS_BRANCH="$params.GPFJS_BRANCH"
    }
    stages {
        stage ('Start') {
            steps {
                zulipSend(
                    message: "Started build #${env.BUILD_NUMBER} of project ${env.JOB_NAME} (${env.BUILD_URL})",
                    topic: "${env.JOB_NAME}")
            }
        
        }

                    // rm -rf gpf
                    // rm -rf gpfjs

        stage('clean') {
            steps {
                sh '''
                    rm -rf builds/*
                '''
            }
        }

        stage('gpf & gpfjs source') {
            steps {
                sh '''
                    echo "GPF_BRANCH=${GPF_BRANCH}"
                    echo "GPFJS_BRANCH=${GPF_BRANCH}"

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

        stage('build gpf development docker image') {
            steps {
                sh '''
                    ./jenkins_docker_build_image.sh
                '''

            }
        }

        stage('tag repos') {
            steps {
                sh '''
                    ./jenkins_tag.sh
                '''
            }
        }

        stage('publish docker image') {
            steps {
                sh '''
                    docker push seqpipe/gpf_dev:${BUILD_NUMBER}
                    docker push seqpipe/gpf_dev:latest
                '''
            }
        }
    }
    post {
        always {
            zulipNotification(
                topic: "${env.JOB_NAME}"
            )      
        }

        success {
            archiveArtifacts artifacts: 'builds/*.tar.gz'
        }
    }
}

