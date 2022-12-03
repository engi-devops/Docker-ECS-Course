# Reset
Color_Off='\033[0m'       # Text Reset
# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

if aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/x8d1s6y8 | grep -q "Login Succeeded"
  then
    echo "${BGreen}========== 1 - Login Succeeded. ==========${BGreen}"
      if docker build -t script-app .
        then
          echo "${BGreen}========== 2 - Docker Build Succeeded. ==========${BGreen}"
            if docker tag script-app:latest public.ecr.aws/x8d1s6y8/script-app:latest
              then
                echo "${BGreen}========== 3 - Docker Build Completed Tag Succeeded. ==========${BGreen}"
                  if docker push public.ecr.aws/x8d1s6y8/script-app:latest
                    then
                      echo "${BGreen}========== 4 - Docker Build Push Succeeded. ==========${BGreen}"
                    else
                      echo "${BRed}********** 4- Docker Build Push Failed. **********${BRed}"
                      exit
                  fi
              else
                echo "${BRed}********** 3- Docker Build Tag Failed. **********${BRed}"
                exit
            fi
        else
          echo "${BRed}********** 2- Docker Build Failed. **********${BRed}"
          exit
      fi
  else
    echo "${BRed}********** 1- Login Failed. **********${BRed}"
    exit
fi
