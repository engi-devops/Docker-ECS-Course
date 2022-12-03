# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# Succeeded
IsDockerLoginSucceeded='\033[1;92m========== 1 -Login Succeeded. ==========\033[1;92m'
IsDockerBuildSuccessded='\033[1;92m========== 2 -Docker Build Succeeded. ==========\033[1;92m'
IsDockerBuildTagSuccessded='\033[1;92m========== 3 -Docker Build Completed Tag Succeeded. ==========\033[1;92m'
IsDockerBuildPushSuccessded='\033[1;92m========== 4 -Docker Build Push Succeeded. ==========\033[1;92m'
# Failed
IsDockerLoginFailed='\033[1;91m********** 1 -Login Failed. **********\033[1;91m'
IsDockerBuildFailed='\033[1;91m********** 2 -Docker Build Failed. **********\033[1;91m'
IsDockerBuildTagFailed='\033[1;91m********** 3 -Docker Build Tag Failed. **********\033[1;91m'
IsDockerBuildPushFailed='\033[1;91m********** 4 -Docker Build Push Failed. **********\033[1;91m'

# Execute Docker Command one By one
if aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/x8d1s6y8 | grep -q "Login Succeeded"
  then
    echo "${IsDockerLoginSucceeded}"
      if docker build -t script-app .
        then
          echo "${IsDockerBuildSuccessded}"
            if docker tag script-app:latest public.ecr.aws/x8d1s6y8/script-app:latest
              then
                echo "${IsDockerBuildTagSuccessded}"
                  if docker push public.ecr.aws/x8d1s6y8/script-app:latest
                    then
                      echo "${IsDockerBuildPushSuccessded}"
                    else
                      echo "${IsDockerBuildPushFailed}"
                      exit
                  fi
              else
                echo "${IsDockerBuildTagFailed}"
                exit
            fi
        else
          echo "${IsDockerBuildFailed}"
          exit
      fi
  else
    echo "${IsDockerLoginFailed}"
    exit
fi
