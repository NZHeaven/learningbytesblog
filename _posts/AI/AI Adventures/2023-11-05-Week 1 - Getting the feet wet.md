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

Before we dive in, let me give you a bit of background about myself and my skills so you know where I am starting from. I'm no AI industry pro or even super experienced in the programming industry. By day, I'm a System Engineer and like all ICT professions these days I code, I have worked on many automations and freelance projects in the past. But my day to day is not coding. I would describe myself as capable but by no means an expert. I do however have confidance in being able to handle the programming side of this adventure, the code will no doubt not be pretty, but I am sure I can get it to work. I think my main shortcomming into this adventure will be my maths knowlage, it's been ages since I tackled any serious maths. But as I always say if there is a will there is a way!

Now, when it comes to AI and deep learning, I'm starting from square one. I haven't read up on it or ventured into this space before. So, these posts point of view, will be from a complete beginner just getting started.

## Day 1-2: Google, google and some more google

My first couple of days, was basically me just googling everthing. Trying to get a broad understanding what AI is, how it is made etc. I started off really foucsing on LLMs (Large language models). LLMs are what gave us Chatgpt. They are notable for there ability to understand and generate natural language.

All my research directed me to a site called [huggingface.co](https://huggingface.co/). Hugging face is a open source community that develops tools and resources to build, deploy, and train machine learning models. They have built lots of fantastic libraires to assit people in creating models, but their main platform allows users to share their own models and datasets. It is all built on top of git, so a crude description would be the 'github' for AI development and sharing.

I highly recomend, if you are brand new like myself, to have a good look arround the models others have created. It shows you the work others are working on and what you can achive if you wish. I spent most of my time, these first couple of days just looking at exisitng models and even downloading and running some of the smaller ones on my own device. Which takes me into my next couple of days.

## Day 2-4: Running Llama2 locally

After getting inspired by what others have built, I was really keen to give some of them a try to see what you can do with them. Something to remember is that the models are just that, models. We need to use some other program to interface with the models, in order to be able to use them. Something you will find is that a lot of models are based on Meta's open-source LLM, Llama2. So my goal was to get Llama 2 running on my own device.

I had a new desktop on the way with a 4090, which would have allowed me to run these models a lot better than my M1 MacBook. Unfortunately, it was damaged in shipping. Fortunately, Llama 2 is available in multiple sizes, so we are still able to utilize a smaller model that can be run on my MacBook.

The first step is to obtain the models from Meta. It's a very simple process. Go to [ai.meta.com/llama/](https://ai.meta.com/llama/) and click the big download button. You will be required to provide some basic information. Make sure to enter a valid email, as they will email you the download link that you can use to download each model. In the email, you will find instructions on how to download the models. Essentially, in their official GitHub repositories, you will find a batch file that you can run to download each model. You will just need to provide your unique download URL. NOTE: The link is only valid for 24 hours, but don't worry, you can reapply if needed.

As I mentioned, there are multiple models, each based on size, and some are tailored to specific needs. For example, the Llama-2 code model is better suited for code-related tasks. I elected to download and run the Llama-2-7b-chat model.

Once I had it downloaded, the next task was to figure out how to run and interface with the model. This is where the extremely popular [llama.cpp](https://github.com/ggerganov/llama.cpp) comes in. Llama.cpp is an open-source project that allows us to interface with Meta's LLMs (and many others). Initially, it was a fork of Meta's own project, just written in C++. The benefit here is that it runs very fast.

For those who wish to do this at home, I recommend reading the excellent article written by Matan Kleyman on [Medium](https://medium.com/vendi-ai/efficiently-run-your-fine-tuned-llm-locally-using-llama-cpp-66e2a7c51300). It's a handy guide to get llama running on your own device. One significant takeaway from the article when running it locally is something called **'Quantization.'**

Quantization allows us to 'compress' our large language models. Most LLMs and deep learning neural networks use large floating-point numbers (32-bit, 16-bit, etc.) as weights. I won't go into details about weights here, but they are essential to how neural networks work. Quantization allows us to convert these large weights into smaller approximations (4-bit, 8-bit, etc.). While we do lose some accuracy, it allows us to compress our models into much smaller sizes, which means the models consume less VRAM, run faster, and take up much less space.

## Day 4-6: Reading

After experimenting with Llama 2 and a few other custom models on my local setup, I wanted to take a step back and try to learn the fundamentals of neural networks – how they're built, and how to create my own from the ground up. This led me to discover an incredible free course created by the fantastic folks behind the fastai Python library. It's aptly named "Practical Deep Learning for Coders," and you can find it [here](https://course.fast.ai/). While they do offer a book for purchase, I've opted to work with their freely available Jupyter notebooks from their [GitHub repository](https://github.com/fastai/fastbook).

What I love about this course is its practical approach. It doesn't overwhelm you with complex math right from the start; instead, it encourages learning by doing. The mathematical and theoretical aspects are introduced gradually as you progress through the course.

My initial days were dedicated to immersing myself in the first chapter. This chapter not only explores the history of AI, deep learning, and neural networks but also reveals a surprising fact: the industry isn't as "new" as we (or atleast I) might think. Many of the foundational theories and concepts date back to the 1960s and even the late 1940s. Real-world neural networks were already in use during that time. It's only the recent advancements in modern hardware that have propelled AI to its current level, but the core principles established by the brilliant minds of the past, armed with little more than the computational power of a calculator, continue to ring true.

## Day 7: Creating my own little, document classifier

In the initial chapter of Practical Deep Learning for Coders, they walk you through creating a straightforward image recognition model based on resnet34. The goal is to use *'computer vision'* to determine whether an image features a cat or a dog.

In my day job, I've been playing with trainable classifiers for Microsoft Purview. When testing trainable classifiers, I wanted to create a classifier to distinguish between New Zealand Acts and New Zealand Bills based on document content. As most of these documents prominently feature "Act" or "Bill" on their cover pages the use of AI was redundant but I was interested to see what purview could do.

I decided to have a go at crafting my own model for this purpose. I took a cue from the cat-and-dog recognition example and set out to retrain the model to classify documents as either a New Zealand Act or a New Zealand Bill.

My first step involved scraping the New Zealand legislation website to obtain copies of Acts and Bills. Subsequently, I devised a script to convert the first page of each PDF document into an image format. (For those interested, Acts represent laws, while Bills pertain to proposed laws.)

With my training data in hand, (Arround 3000 documeents/images) I allocated 5% of the documents for verification purposes after training the model. Employing the same resnet34 model architecture, I trained the model to determine whether a document qualifies as a New Zealand Act. Below, you'll find the code I used for this, which incorporates a verification set of 20% and a training span of 4 epochs. (You will notice is very similar to the cats and dogs example from the book)

```python
from fastai.vision.all import *
from pathlib import Path

data = Path('/Users/joshb/Documents/AI_Model_NZ_Acts_Classifier/Model_V1/Dataset')

def is_act(x): return x.startswith('act_')

dls = ImageDataLoaders.from_name_func(
    data,get_image_files(data),valid_pct=0.2,seed=42,
    label_func=is_act,item_tfms=Resize(224))

learn = vision_learner(dls,resnet34,metrics=error_rate)
learn.fine_tune(4)
```

```
epoch	train_loss	valid_loss	error_rate	time
0	0.138132	0.066582	0.009019	08:29
1	0.085583	0.051106	0.007892	08:36
2	0.063383	0.044638	0.007328	08:37
3	0.046783	0.042222	0.007328	10:23
```


Once trained I took the 5% data I had reserved and ran it against the model. Every single time the model accurately detected if the document was a NZ act or not.

I do know that this example is very basic, but I am surprised at how easy it is to take an existing computer vision model, strip the last layer and retrain it to work for your specific use case.

## Summary

All in all, I must say it's been an awesome first week, and I've soaked up a ton of knowledge. If there's one thing I'd strongly recommend, it's for anyone brand new and eager to dive into the world of neural networks and deep learning to give ["Practical Deep Learning for Coders"](https://course.fast.ai/) by the folks at fast.ai a read. I'm just starting chapters 2 and 3, and I'm totally hooked.

Stay tuned for my next update on my AI learning journey.

Happy learning,
Josh
