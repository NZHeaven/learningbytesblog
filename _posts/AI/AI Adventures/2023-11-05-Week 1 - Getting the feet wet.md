---
title: "AI Adventures (Week 1) -  Getting the feet wet"
date: 2023-11-05 8:25:00 +1200
categories: [Programming, AI]
tags: [AI adventures,python, deep learning, AI, blog]
---

## Introduction

With the growing fascination and the rapid evolution of AI, particularly generative AI, I figured it was about time for me to dive into the world of this technology.

I've been meaning to do this for quite a few years, but I've often found it a challenge to locate a solid starting point. Luckily, as interest in AI and deep learning has surged, an abundance of incredible free resources and guides has become available. Not to mention, there are some fantastic libraries out there that take care of much of the nitty-gritty technical coding, making it easier for us to craft and prototype our own models and programs.

Therefore I've decided to embark on a series of blog posts to chronicle my journey, share intriguing discoveries, and offer up some handy resources for fellow AI noobies like myself. Grab a coffee and join me in this adventure, where I'll attempt to navigate my way to a better understanding of AI.

### Background

Before we dive in, let me give you a bit of background about myself and my skills so you know where I am starting from. I'm no AI industry pro or even super experienced in the programming industry. By day, I'm a System Engineer and like all ICT professions these days I code, I have worked on many automations and freelance projects in the past. But my day to day is not coding. I would describe myself as capable but by no means an expert. I do however have confidance in being able to handle the programming side of this adventure, the code will no doubt not be pretty, but I am sure I can get it to work. I think my main shortcomming into this advendure will be my maths knowlage, it's been ages since I tackled any serious maths. But as I always say if there is a will there is a way!

Now, when it comes to AI and deep learning, I'm starting from square one. I haven't read up on it or ventured into this space before. So these posts point of view will be from a complete beginner just getting started.

## Day 1-2: Google, google and some more google

My first couple of days, was basically me just googling everthing. Trying to get a broad understanding what AI is, how it is made etc. I started off really foucsing on LLMs (Large language models). LLMs are what gave us Chatgpt. They are notable for there ability to understand and generate natural language.

All my research directed me to a site called [huggingface.co](https://huggingface.co/). Hugging face is a open source community that develops tools and resources to build, deploy, and train machine learning models. They have build lots of fantastic libraires to assit people in creating models, but there main platform allows users to share their own models and datasets. It is all build on top of git, so a crude description would be the 'github' for AI development and sharing.

I highly recomend if you are brand new like myself, to have a good look arround the models others have created. It shows you the work others are working on and what you can achive if you wish. I send most of my time these first couple of days just looking at exisitng models and even downloading and running some of the smaller ones on my own device. Which takes me into my next couple of days.

## Day 2-4: Running Llama2 locally

After getting inspired looking at what others have build I was really keen to give some of them a try to see what you can do with them. Something to remeber is that the models are just that models. We need use another program to interface with the models to be able to use them. Something you will find is that alot of models are based on Meta's open source LLM Llama2. So my goal was to get Llama 2 running on my own device.

I had a new desktop on the way with a 4090 which would have allowed me to run these models alot better them my M1 macbook but unfortunatly it was damaged in shipping. Fortuantly Llama 2 is available in muiltiple sizes so we are still able to utilize a smaller model that can be run on my macbook.

The first step is to get the models from Meta. Is a very simple process go to [ai.meta.com/llama/](https://ai.meta.com/llama/) and press the big download button. You are required to provide some basic information. Make sure to enter a valid email as they will email you the download link you can use to download each model. In the email you will find instruction on how to download the models, but essentailly in there offical github repositories you will find a batch file you can run to download each model. You will just need to supply your unique download url. NOTE: The link is only valid for 24hr, but do not worry you can reapply again if needed.

As I mentioned there are muitple models, they are each based on the size and there are some that a taylored to a more specific need. For example the llama-2 code model is better at code related tasks. I elected to download and run the Llama-2-7b-chat model.

Once I had it downloaded the next task is figuring out how to run and 'interface' with the model. This is where the extremly popular [llama.cpp](https://github.com/ggerganov/llama.cpp) comes in. Llama.cpp is a opensoruce project that allows us to interface with metas llms. Initally it is a fork metas own just written in cpp. The benifit here is that it runs very fast.

For thoes that wish to do this at home, have a read over the execelent articlue written by Matan Kleyman on [medium](https://medium.com/vendi-ai/efficiently-run-your-fine-tuned-llm-locally-using-llama-cpp-66e2a7c51300) Is a handy guide to get it running on your own device. A really big takeway you should take from the articule and running it on your own device is something called: **'Quantization'**

Quantization allows us to 'compress' our large language models. Most LLMs and deep learning neural networks use large floating point numbers (32 bit, 16 bit etc) as weights. I will not going into weights here but they are esential to how neural network works. Quantization allows us to covert these large weights and convert them to a smaller approximate (4bit/8bit etc). We do lose some accuracy but it allows us to compress our models down to a much smaller size, meaning the models take up less VRAM to run, are faster and take up alot less space.

Remember to run models on a gpu you need load the entire model into vram. NOTE: you can run models on a cpu, it generally is much slower however.

## Day 4-6: Reading

After running Llama 2 locally and some other custom models locally I really wanted to start from the beginning and understand neural networks, how they are made, creating my own etc. This lead me to finding an amazing free course created by the awseom folk who created the fastai python libaray. [Practical Deep Learning for coders](https://course.fast.ai/) is the name of there course. You can purchase there book if you wish, however there book is created from all there freely availbe jupyter notebooks in there [github repo](https://github.com/fastai/fastbook) that is what I am using. One think I love about this corse so far, is they do not focus just on the maths, you spend alot of time learning by doing. With the maths and theory comming in as you go.

I spend the first couple of days reading just there first chapter. It goes into the history of AI/Deep learning and neural networks. I was amazed that the industry is not really "new" so much of the theory was created way back in the 60's and even the late 40s. With real world neural networks being used arround that time too. Only resently with how fast modern hardware has become has allowed AI to reach the level it is today, but the core logic has not really changed. What the geniuss in the old days where able to create with the compute power of a calculator never ceases to amazing me.

## Day 7: Creating my own little, document classifier



