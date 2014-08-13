

# Install

* Install the [Docker.io](https://www.docker.com/)

* Clone the repository

    ```git clone https://github.com/latsku/Ell-i_emulator_Dockerfile.git```

* Run to build the environment

    ```sudo docker build -t ELL-i/emulator --rm Ell-i_emulator_Dockerfile```

  * To rebuild the environment with up to date software.

    ```sudo docker build -t ELL-i/emulator --rm --no-cache Ell-i_emulator_Dockerfile```

* Start the enviroment

    ```sudo docker run -t -i ELL-i/emulator /bin/bash```


# Running the tests (inside the environment)

    ./run-tests.sh run-all

# Running the tests (outside the environment)

    sudo docker run -t -i ELL-i/emulator /data/PyBot-Tests/run-tests.sh run-all
