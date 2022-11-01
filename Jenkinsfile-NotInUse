properties([
    parameters([
        password( name: 'AWS_ACCESS_KEY_ID', 
                defaultValue: '', 
                description: 'AWS Credentials: AWS access key ID'),
        password( name: 'AWS_SECRET_ACCESS_KEY', 
                defaultValue: '', 
                description: 'AWS Credentials: AWS secret access key'),
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
    
    stage('Clean workspace'){
        cleanWs()
    }
    
    //clone terraform repo
    stage('Git Prep'){
        sh 'echo "Cloning git repo to following path: $(pwd)"'
        git branch: "${GIT_BRANCH}", changelog: false, poll: false, url: "${GIT_URL}"
        sh "ls"
    }
    
//might pe helpful if terraform not in path and kept somewhere on your local jenkins machine (?)
tool name: 'terraform', type: 'terraform'

    stage('Configure terraform'){
        //add terraform tool to path
        env.TERRAFORM_HOME="${tool 'terraform'}"
        env.PATH="${env.TERRAFORM_HOME}:${env.PATH}"
        
        //check
        sh "which terraform"
        
        //authenticate to AWS
        sh '''
        export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
        export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
        '''
        // // if needed
        // sh '''
        // unset AWS_ACCESS_KEY_ID
        // unset AWS_SECRET_ACCESS_KEY
        // '''
    }
    
    // Deploy or Destroy the selected infrastructure
    stage("APPLY/DESTROY infra") {
        if (params.ACTION == "Apply"){
            sh '''
                cd "live/${ENV}"
                echo "Current working directory is: $(pwd)"
                terraform init 
                terraform plan -out=plan
            '''
            env.PLAN = input message: 'Do you want to implement plan?', parameters: [choice(name: 'PLAN', choices: ['YES', 'NO'], description: 'Implement plan')]
            if (env.PLAN == 'YES') {
                sh '''
                    cd "live/${ENV}"
                    terraform apply plan
                '''
            }
        }
        if (params.ACTION == "Destroy"){
            sh '''
                cd "live/${ENV}"
                echo "Current working directory is: $(pwd)"
                terraform init 
                terraform plan -destroy -out=plan
            '''
            env.PLAN = input message: 'Do you want to implement destruction plan?', parameters: [choice(name: 'PLAN', choices: ['YES', 'NO'], description: 'Implement plan')]
            if (env.PLAN == 'YES') {
                sh '''
                    cd "live/${ENV}"
                    terraform apply plan
                '''
            }
        }
    }
    
    stage('Clean workspace'){
        cleanWs()
    }
    
}

