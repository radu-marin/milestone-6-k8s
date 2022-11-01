properties([
    parameters([
        string( name: 'GIT_URL',
                defaultValue: 'https://github.com/radu-marin/milestone-6-k8s',
                description: 'The github repository link'),
        string( name: 'GIT_BRANCH',
                defaultValue: 'main',
                description: 'The github branch link'),
        choice( name: 'ENV', 
                choices: ['DEV/network', 'DEV/EKS', 'global/iam'], 
                description: 'Choose deployment environment (OBS: deploy `network` and `iam` before `EKS`)'),
        choice( name: 'ACTION', 
                choices: ['Apply', 'Destroy'], 
                description: 'Choose the required action for infrastructure')        
    ])
])

node("linux"){
    checkout scm
    withCredentials([string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'), 
                     string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')]) {
        docker.image('terraform').withRun('-e "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" -e "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY"') { c ->
            docker.image('terraform').inside {
                sh '''
                cd "live/${ENV}"
                echo "Current working directory is: $(pwd)"
                terraform init
                terraform plan -out=plan
                '''
            }
        }




    }
}