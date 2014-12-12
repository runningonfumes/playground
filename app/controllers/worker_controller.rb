class WorkerController < ApplicationController

def start
    HardWorker.perform_async('bob', 5)
   render text: 'Start working'
end
end
