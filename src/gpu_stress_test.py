import time
import os

def simulate_inference():
    print(f"Starting simulated AI inference on POD: {os.getenv('HOSTNAME')}")
    # Simulating GPU memory allocation and computation
    duration = int(os.getenv('STRESS_DURATION', 60))
    start_time = time.time()
    
    while time.time() - start_time < duration:
        # Mocking heavy matrix multiplication workload
        _ = [i**2 for i in range(10000)]
        time.sleep(0.1)
    
    print("Inference task completed successfully.")

if __name__ == "__main__":
    simulate_inference()
