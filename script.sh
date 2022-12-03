GREEN=$'\033[0;32m'
RED=$'\033[0;31m' 
BLUE=$'\033[0;36m' 
WHITE=$'\033[0;37m' 

if aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/x8d1s6y8 | grep -q "Login Succeeded"
  then
    echo "${GREEN}========== 1 - Login Succeeded. ==========${GREEN}"
      if docker build -t script-app .
        then
          echo "${GREEN}========== 2 - Docker Build Succeeded. ==========${GREEN}"
            if docker tag script-app:latest public.ecr.aws/x8d1s6y8/script-app:latest
              then
                echo "${GREEN}========== 3 - Docker Build Completed Tag Succeeded. ==========${GREEN}"
                  if docker push public.ecr.aws/x8d1s6y8/script-app:latest
                    then
                      echo "${GREEN}========== 4 - Docker Build Push Succeeded. ==========${GREEN}"
                    else
                      echo "${RED}********** 4- Docker Build Push Failed. **********${RED}"
                      exit
                  fi
              else
                echo "${RED}********** 3- Docker Build Tag Failed. **********${RED}"
                exit
            fi
        else
          echo "${RED}********** 2- Docker Build Failed. **********${RED}"
          exit
      fi
  else
    echo "${RED}********** 1- Login Failed. **********${RED}"
    exit
fi
