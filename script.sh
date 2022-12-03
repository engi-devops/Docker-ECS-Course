GREEN=$'\033[0;32m'
RED=$'\033[0;31m' 
BLUE=$'\033[0;36m' 
WHITE=$'\033[0;37m' 

if aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/x8d1s6y8 | grep -q "Login Succeeded"
  then
    echo '\033[1;32m========== 1 - Login Succeeded. ==========\033[1;32m'
      if docker build -t script-app .
        then
          echo '\033[1;32m========== 2 - Docker Build Succeeded. ==========\033[1;32m'
            if docker tag script-app:latest public.ecr.aws/x8d1s6y8/script-app:latest
              then
                echo '\033[1;32m========== 3 - Docker Build Completed Tag Succeeded. ==========\033[1;32m'
                  if docker push public.ecr.aws/x8d1s6y8/script-app:latest
                    then
                      echo '\033[1;32m========== 4 - Docker Build Push Succeeded. ==========\033[1;32m'
                    else
                      echo "\033[1;31m********** 4- Docker Build Push Failed. **********\033[1;31m"
                      exit
                  fi
              else
                echo "\033[1;31m********** 3- Docker Build Tag Failed. **********\033[1;31m"
                exit
            fi
        else
          echo "\033[1;31m********** 2- Docker Build Failed. **********\033[1;31m"
          exit
      fi
  else
    echo "\033[1;31m********** 1- Login Failed. **********\033[1;31m"
    exit
fi
