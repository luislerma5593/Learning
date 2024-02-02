# OpenAI API

key = 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

## Introduction

```py
# Import the OpenAI client
from openai import OpenAI

# Create the OpenAI client and set your API key
client = OpenAI(api_key="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")

# Create a request to the Completions endpoint
response = client.completions.create(
  # Specify the correct model
  model="gpt-3.5-turbo-instruct",
  prompt="Who developed ChatGPT?"
)

# Extract the total_tokens from response
print(response.usage.total_tokens)
print(response.choices[0].text)
```

### Endpoints

* Completion - Single-turn tasks
 
* Chat - Multi-turn tasks
	* System: Controls assistant's behavior
	* User
	* Assistant
	
* Moderation - Check if content violates policies


Chat endpoint
```py
# Set your API key
client = OpenAI(api_key="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")

# Create a request to the Chat Completions endpoint
response = client.chat.completions.create(
  model="gpt-3.5-turbo",
  max_tokens=150,
  messages=[
    {"role": 'system',
     "content": "You are a helpful data science tutor."},
    {"role" : "user",
     "content" : "What is the difference between a for loop and a while loop?"}
  ]
)

# Extract and print the assistant's text response
print(response.choices[0].message.content)
```

Python assistant example
```py
# Set your API key
client = OpenAI(api_key="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")

response = client.chat.completions.create(
   model="gpt-3.5-turbo",
   # Add a user and assistant message for in-context learning
   messages=[
     {"role": "system", "content": "You are a helpful Python programming tutor."},
     {"role":"user", "content": "Explain what the min() function does."},
     {"role":"assistant", "content": "The min() function returns the smallest item from an iterable."},
     {"role": "user", "content": "Explain what the type() function does."}
   ]
)

print(response.choices[0].message.content)
```

Conversation example
```py
# Set your API key
client = OpenAI(api_key="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")

messages = [{"role": "system", "content": "You are a helpful math tutor."}]
user_msgs = ["Explain what pi is.", "Summarize this in two bullet points."]

for q in user_msgs:
    print("User: ", q)
    
    # Create a dictionary for the user message from q and append to messages
    user_dict = {"role": "user", "content": q}
    messages.append(user_dict)
    
    # Create the API request
    response = client.chat.completions.create(
        model="gpt-3.5-turbo",
        messages=messages,
        max_tokens=100
    )
    
    # Convert the assistant's message to a dict and append to messages
    assistant_dict = {"role": "assistant", "content": response.choices[0].message.content}
    messages.append(assistant_dict)
    print("Assistant: ", response.choices[0].message.content, "\n")
```

---

### Beyond text completion

#### Text and capabilities

* Zero-shot prompting

In-context learning:
* One-shot prompting
* Few-shots prompting

#### Text moderation

* Identifying inapportiate content

* Using the model `text-moderation-model`

```py
# Set your API key
client = OpenAI(api_key="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")

# Create a request to the Moderation endpoint
response = client.moderations.create(
    model = 'text-moderation-latest',
    input = "My favorite book is How to Kill a Mockingbird."
)

# Print the category scores
print(response.results[0].category_scores)
```

#### Speech-to-Text

* client.audio.transcriptions.create(model='whisper-1', file=audio_file)

```py
# Set your API key
client = OpenAI(api_key="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")

# Open the openai-audio.mp3 file
audio_file = open('openai-audio.mp3', 'rb')

# Create a transcript from the audio file
response = client.audio.transcriptions.create(model="whisper-1", file = audio_file)

# Extract and print the transcript text
print(response.text)
```

#### Speech translation with Whisper

* Just changing the method transcription > translation
* Can use prompt parameter to provide context

```py
# Set your API key
client = OpenAI(api_key="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")

# Open the audio.wav file
audio_file = open('audio.wav','rb')

# Write an appropriate prompt to help the model
prompt = "Audio is related to a recen World Bank report"

# Create a translation from the audio file
response = client.audio.translations.create(model='whisper-1', file=audio_file, prompt=prompt)

print(response.text)
```

#### Combining models

* First speech-to-text and the output, is the input for the chat endpoint

```py
# Set your API key
client = OpenAI(api_key="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")

# Open the audio.wav file
audio_file = open('audio.wav', "rb")

# Create a transcription request using audio_file
audio_response = client.audio.transcriptions.create(model='whisper-1', file=audio_file)

# Create a request to the API to identify the language spoken
chat_response = client.chat.completions.create(
    model = 'gpt-3.5-turbo',
    messages = [{'role': 'user', 'content': "What is the language from the following conversation: " + audio_response.text}]
    )
print(chat_response.choices[0].message.content)
```

Creating meeting summaries
```py
# Set your API key
client = OpenAI(api_key="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")

# Open the datacamp-q2-roadmap.mp3 file
audio_file = open('datacamp-q2-roadmap.mp3', 'rb')

# Create a transcription request using audio_file
audio_response = client.audio.transcriptions.create(
    model = 'whisper-1',
    file = audio_file
)

# Create a request to the API to summarize the transcript into bullet points
chat_response = client.chat.completions.create(
    model = 'gpt-3.5-turbo',
    messages = [{'role':'user', 'content': "Summarize into concise bullet points: " + audio_response.text}]
)
print(chat_response.choices[0].message.content)
```

## Embeddings

* Semantic search engines use embeddigs to understand intent and context

Into a model dump
```py
# Create an OpenAI client and set your API key
client = OpenAI(api_key="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")

# Create a request to obtain embeddings
response = client.embeddings.create(
    model = 'text-embedding-ada-002',
    input = 'This will be converted into an embedding'

)

# Convert the response into a dictionary
response_dict = response.model_dump()

print(response_dict)
```