# Risc-V - Pipelined - RV32I -
This project is developed from Single-cycle-process-risc-v-rv32I repository on my github.
The project designs RV32I with pipelined architecture.
The pipelined core is designed in 5 stages. 
In this repository, I have designed 3 different models include:
  - Stall model: in this model, all hazard are solved by using stall and flush.
  - Forwarding model: in this model, data hazards are solved by using forwarding technique.
  - Branch prediction model: in this model, branch and jump instructions are optimized by using branch prediction technique.
    
The detailed block diagram of stall model is depicted in the below picture.
![image](https://github.com/Stork1323/Risc-V-Pipelined-RV32I-/assets/136346435/7c76f64d-d2dd-4e3c-b103-23eec925b33e)

The detailed block diagram of forwarding model is depicted in the below picture.
![image](https://github.com/Stork1323/Risc-V-Pipelined-RV32I-/assets/136346435/1931168b-d377-4fd8-a6bb-ac441b7074ef)


In my repository, there are some files written by my teacher, so please do not share these documents widely.
