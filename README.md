# Risc-V - Pipelined - RV32I -
This project is developed from Single-cycle-process-risc-v-rv32I repository on my github.
The project designs RV32I with pipelined architecture.
The pipelined core is designed in 5 stages. 
In this repository, I have designed 4 different models include:
  - Stall model: in this model, all hazard are solved by using stall and flush.
  - Forwarding model: in this model, data hazards are solved by using forwarding technique.
  - Branch prediction models: in this models, branch and jump instructions are optimized by using branch prediction technique. Two models contain static branch prediction (always-taken) and dynamic branch prediction (2 bit prediction).
    
The detailed block diagram of stall model is depicted in the below picture.
![image](https://github.com/Stork1323/Risc-V-Pipelined-RV32I-/assets/136346435/7c76f64d-d2dd-4e3c-b103-23eec925b33e)

The detailed block diagram of forwarding model is depicted in the below picture.
![image](https://github.com/Stork1323/Risc-V-Pipelined-RV32I-/assets/136346435/1931168b-d377-4fd8-a6bb-ac441b7074ef)

The detailed block diagram of static branch prediction (always - taken) is depicted in the below picture.
![block_diagram_pipeline_branch_prediction_model](https://github.com/Stork1323/Risc-V-Pipelined-RV32I-/assets/136346435/5559e36f-b25b-433c-820b-872a8f4752b1)


The block diagram of dynamic static prediction (2 bit prediction) is same with static branch prediction, there is an additional state machine describe 2 bit prediction in the below picture.
![image](https://github.com/Stork1323/Risc-V-Pipelined-RV32I-/assets/136346435/16c3abd7-50cd-4bda-a92a-5eebe0260ea2)



In my repository, there are some files written by my teacher, so please do not share these documents widely.
