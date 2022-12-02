if aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/x8d1s6y8 | grep -q "Login Succeeded"
  then
    echo '1 - Login Succeeded.'
      if docker build -t script-app .
        then
          echo '2 - Docker Build Succeeded.'
            if docker tag script-app:latest public.ecr.aws/x8d1s6y8/script-app:latest
              then
                echo '3 - Docker Build Completed Tag Succeeded.'
                  if docker push public.ecr.aws/x8d1s6y8/script-app:latest
                    then
                      echo '4 - Docker Push Succeeded.'
                    else
                      echo "Docker Push Failed"
                      exit
                  fi
              else
                echo "Docker Build Tag Failed"
                exit
            fi
        else
          echo "Docker Build Failed"
          exit
      fi
  else
    echo "Login Failed."
    exit
fi  