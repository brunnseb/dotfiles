return {
  {
    "pablopunk/pi.nvim",
    opts = {
      provider = "llama.cpp", -- Use local llama.cpp server for AI inference
      model = "qwen3.6-35b", -- Qwen 3.6 27B parameter model
      binary = "omp", -- Oh My Pi CLI binary
    },
  },
}
