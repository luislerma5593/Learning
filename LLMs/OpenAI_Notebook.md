# OpenAI API

key = ---key---
key2 = ---key---

## Working with OpenAI API

```py
# Import the OpenAI client
from openai import OpenAI

# Create the OpenAI client and set your API key
client = OpenAI(api_key="---key---")

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
client = OpenAI(api_key="---key---")

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
client = OpenAI(api_key="---key---")

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
client = OpenAI(api_key="---key---")

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
client = OpenAI(api_key="---key---")

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
client = OpenAI(api_key="---key---")

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
client = OpenAI(api_key="---key---")

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
client = OpenAI(api_key="---key---")

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
client = OpenAI(api_key="---key---")

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

# Embeddings

* Semantic search engines use embeddigs to understand intent and context

Into a model dump
```py
# Create an OpenAI client and set your API key
client = OpenAI(api_key="---key---")

# Create a request to obtain embeddings
response = client.embeddings.create(
    model = 'text-embedding-ada-002',
    input = 'This will be converted into an embedding'

)

# Convert the response into a dictionary
response_dict = response.model_dump()
print(response_dict)

# Extract the embeddings from response_dict
print(response_dict['data'][0]['embedding'])
```

```py
# Extract a list of product short descriptions from products
product_descriptions = [product['short_description'] for product in products]

# Create embeddings for each product description
response = client.embeddings.create(
    model = 'text-embedding-ada-002',
    input = product_descriptions)
response_dict = response.model_dump()

# Extract the embeddings from response_dict and store in products
for i, product in enumerate(products):
    product['embedding'] = response_dict['data'][i]['embedding']
    
print(products[0].items())
```

### Text similarity

```py
1.
# Define a create_embeddings function
def create_embeddings(texts):
  response = client.embeddings.create(
    model="text-embedding-ada-002",
    input=texts
  )
  response_dict = response.model_dump()
  
  return [data['embedding'] for data in response_dict['data']]

# Embed short_description and print
print(create_embeddings(short_description)[0])

# Embed list_of_descriptions and print
print(create_embeddings(list_of_descriptions)[0])

---

2. 
# Embed the search text
search_text = "soap"
search_embedding = create_embeddings(search_text)[0]

distances = []
for product in products:
  # Compute the cosine distance for each product description
  dist = distance.cosine(search_embedding, product['embedding'])
  distances.append(dist)

# Find and print the most similar product short_description    
min_dist_ind = np.argmin(distances)
print(products[min_dist_ind]['short_description'])
```

### Embedding my products description excercise

```py
# Set your API key
client = OpenAI(api_key="---")

# Define a function to combine the relevant features into a single string
def create_product_text(product):
  return f"""Title: {product['title']}
Description: {product['short_description']}
Category: {product['category']}
Features: {', '.join(product['features'])}"""

# Combine the features for each product
product_texts = [create_product_text(product) for product in products]

# Create the embeddings from product_texts
product_embeddings = create_embeddings(product_texts)

---
#Function to get similarities
def find_n_closest(query_vector, embeddings, n=3):
  distances = []
  for index, embedding in enumerate(embeddings):
    # Calculate the cosine distance between the query vector and embedding
    dist = distance.cosine(query_vector, embedding)
    # Append the distance and index to distances
    distances.append({"distance": dist, "index": index})
  # Sort distances by the distance key
  distances_sorted = sorted(distances, key=lambda x: x['distance'])
  # Return the first n elements in distances_sorted
  return distances_sorted[0:n]
  
---
  
  # Set your API key
client = OpenAI(api_key="---")

# Create the query vector from query_text
query_text = "computer"
query_vector = create_embeddings(query_text)[0]

# Find the five closest distances
hits = find_n_closest(query_vector, product_embeddings, 5)

print(f'Search results for "{query_text}"')
for hit in hits:
  # Extract the product at each index in hits
  product = products[hit['index']]
  print(product["title"])
```

### Recommendation system

```py
# Set your API key
client = OpenAI(api_key="---")

# Combine the features for last_product and each product in products
last_product_text = create_product_text(last_product)
product_texts = [create_product_text(product) for product in products]

# Embed last_product_text and product_texts
last_product_embeddings = create_embeddings(last_product_text)[0]
product_embeddings = create_embeddings(product_texts)

# Find the three smallest cosine distances and their indexes
hits = find_n_closest(last_product_embeddings, product_embeddings)

for hit in hits:
  product = products[hit['index']]
  print(product['title'])
```

with user history...

```py
# Set your API key
client = OpenAI(api_key="sk----")

# Prepare and embed the user_history, and calculate the mean embeddings
history_texts = [create_product_text(article) for article in user_history]
history_embeddings = create_embeddings(history_texts)
mean_history_embeddings = np.mean(history_embeddings, axis=0)

# Filter products to remove any in user_history
products_filtered = [product for product in products if product not in user_history]

# Combine product features and embed the resulting texts
product_texts = [create_product_text(product) for product in products_filtered]
product_embeddings = create_embeddings(product_texts)

hits = find_n_closest(mean_history_embeddings, product_embeddings)

for hit in hits:
  product = products_filtered[hit['index']]
  print(product['title'])
```

### Classification tasks

For this excercise, will be used "zero-shot classification"
* Not using labeled data

Process:
1. Embedd class descriptions
2. Embed the item to classify
3. Compute cosine distances
4. Assign the most similar label

```py

sentiments = [{'label': 'Positive'},
              {'label': 'Neutral'},
              {'label': 'Negative'}]

reviews = ["The food was delicious!",
           "The service was a bit slow but the food was good",
           "Never going back!"]

# Create a list of class descriptions from the sentiment labels
class_descriptions = [sentiment['label'] for sentiment in sentiments]

# Embed the class_descriptions and reviews
class_embeddings = create_embeddings(class_descriptions)
review_embeddings = create_embeddings(reviews)

# Define a function to return the minimum distance and its index
def find_closest(query_vector, embeddings):
  distances = []
  for index, embedding in enumerate(embeddings):
    dist = distance.cosine(query_vector, embedding)
    distances.append({"distance": dist, "index": index})
  return min(distances, key=lambda x: x["distance"])

for index, review in enumerate(reviews):
  # Find the closest distance and its index using find_closest()
  closest = find_closest(review_embeddings[index], class_embeddings)
  # Subset sentiments using the index from closest
  label = sentiments[closest['index']]['label']
  print(f'"{review}" was classified as {label}')
```

## Vector databases

Components to store:
* Embeddings
* Source texts
* Metadata
	* IDs and references
	* Additional data useful for filtering results
	Tip: Don't store source text as metadata

Open source, dedicated vector DBs:
* Chroma
* Vespa
* Marqo
* LanceDB
* qdrant
* Milvus

Which solution is the best?

This excercises will be done with Chroma DB

### Creating DB

```py
### 1. Connecting to the database
import chroma db
client = chromedb.PersistentClint(path='...')

### 2. Creating a collection (analogous to tables)
from chromadb.utiñs.embedding_functions import OpenAIEmbeddingFunction
collection = client.create_collection(
	name = 'my_collection',
	embedding_function = OpenAIEmbeddingFunction(api_key='...')
)

#For inspecting collections
client.list_collections()

### 3. Insert embeddings

#### Single document

# - IDs must be provided
# - Embeddings will be created by he collection

collection.add(ids=['my-doc'], documents = ['This is the source text'])

#### Multiple documents

collection.add(	ids=['my-doc1', 'my-doc2'], 
				documents = ['This is doc 1', 'This is doc 2'])
				
# Inspecting a collection

collection.count() #Return the number of docs
collection.peak() #Return top 10 items
collection.get(ids=['s59'])
```

Excercise with Netflix information

```py
# Create a persistant client
client = chromadb.PersistentClient()

# Create a netflix_title collection using the OpenAI Embedding function
collection = client.create_collection(
  name="netflix_titles",
  embedding_function=OpenAIEmbeddingFunction(api_key="---")
)

# List the collections
print(client.list_collections())

### Cost calculation

# Load the encoder for the OpenAI text-embedding-ada-002 model
enc = tiktoken.encoding_for_model("text-embedding-ada-002")

# Encode each text in documents and calculate the total tokens
total_tokens = sum(len(enc.encode(text)) for text in documents)

cost_per_1k_tokens = 0.0001

# Display number of tokens and cost
print('Total tokens:', total_tokens)
print('Cost:', cost_per_1k_tokens * total_tokens / 1000)}

# Recreate the netflix_titles collection
collection = client.create_collection(
  name="netflix_titles",
  embedding_function=OpenAIEmbeddingFunction(api_key="---")
)

# Add the documents and IDs to the collection
collection.add(ids=ids, documents=documents)

# Print the collection size and first ten items
print(f"No. of documents: {collection.count()}")
print(f"First ten documents: {collection.peek()}")
```

### Querying and updating DB

client.get_collection()
collection.query(query_texts=['...'], n_results = 3)
collection.update()
collection.upsert()  		# Insert if doesn't exist, update if exists
collection.delete(ids=[])	# Delete items from a collection
client.reset()	# Delete all collections and items

```py
# Retrieve the netflix_titles collection
collection = client.get_collection(
  name="netflix_titles",
  embedding_function=OpenAIEmbeddingFunction(api_key="sk----")
)

# Query the collection for "films about dogs"
result = collection.query(query_texts=['films about dogs'], n_results=3)

print(result)

# Retrieve the netflix_titles collection
collection = client.get_collection(
  name="netflix_titles",
  embedding_function=OpenAIEmbeddingFunction(api_key="sk----")
)

# Update or add the new documents
collection.upsert(ids=[new_data[0]['id'], new_data[1]['id']], documents=[new_data[0]['document'], new_data[1]['document']])

# Delete the item with ID "s95"
collection.delete(ids = ['s95'])

result = collection.query(
  query_texts=["films about dogs"],
  n_results=3
)
print(result)
```


### Multiple queries and filtering

```py
# Retrieve the netflix_titles collection
collection = client.get_collection(
  name="netflix_titles",
  embedding_function=OpenAIEmbeddingFunction(api_key="---")
)

reference_ids = ['s999', 's1000']

# Retrieve the documents for the reference_ids
reference_texts = collection.get(ids = reference_ids)['documents']

# Query using reference_texts
result = collection.query(
  query_texts = reference_texts,
  n_results=3
)

print(result['documents'])


### Filtering using metadata

# Retrieve the netflix_titles collection
collection = client.get_collection(
  name="netflix_titles",
  embedding_function=OpenAIEmbeddingFunction(api_key="---")
)

reference_texts = ["children's story about a car", "lions"]

# Query two results using reference_texts
result = collection.query(
  query_texts = reference_texts,
  n_results = 2,
  # Filter for titles with a G rating released before 2019
  where={
    '$and': [
        {"rating": 
        	{'$eq': 'G'}
        },
        {"release_year": 
         	{"$lt" : 2019}
        }
    ]
  }
)

print(result['documents'])
```

---

# ChatGPT Prompt Engineering for Developers

## Introduction to Prompt Engineering Best Practices

Control parameters

* temperature: Controls answer's randomness
* max_tokens: maximum number of tokens


> get_reponse function
```py
# Set your API key
client = OpenAI(api_key="***")

def get_response(prompt):
  # Create a request to the chat completions endpoint
  response = client.chat.completions.create(
    model="gpt-3.5-turbo",
    # Assign the role and content for the message
    messages=[{"role": 'user', "content": prompt}], 
    temperature = 0)
  return response.choices[0].message.content

# Test the function with your prompt
response = get_response("Write a poem about ChatGPT")
print(response)

---

# CONDITIONAL FORMATTING

# Create the instructions
instructions = "You will be provided with a text delimited by triple backticks. Infer its language and the number of sentences it contains. Then, if the text has more than one sentence, generate a suitable title for it. Otherwise, if the text contains only one sentence, write 'N/A' for the title."

# Create the output format
output_format = """The output should follow this format:
          - Text: <the given text>
          - Language: <the text language>
          - N_sentences: <number of sentences>
          - Title: <the generated title>'."""

prompt = instructions + output_format + f"```{text}```"
response = get_response(prompt)
print(response)
```

### Recommendations for prompts

* Use verbs that tell that to do, don't use amibuouis verbs like "think"
* Don't write "short answer", be specific, like limit numbers of words, paragraphs, etc.
* Use delimiters to specify input parts, like "(), [], :"
* Use f strings

### Output structures
* Table
* List
* Structured paragraph
* Custom format

## Advanced Prompt Engineering Strategies

### Zero-shot prompting
* Without providing examples
* Responses based on model's knowledge
* Idual for quick and uncomplicated tasks

### One-shot prompting
* Provide single question-answer example to model
* Useful for formatting or style

```py
# Create a one-shot prompt
prompt = """
			Q: Extract odd numbers from {1, 3, 7, 12, 19} 
			A: {1, 3, 7, 19}
            Q: Extract odd numbers from {3, 5, 11, 12, 16} 
			A:"""

response = get_response(prompt)
print(response)
```

### Few-shot prompting
* Provide more than one example to the model
* Powerful for complex tasks like classification

* Choose number of shots according to task complexity 
	* Fewer shots 	> Basic tasks
	* Diverse shots > Complex tasks (Classification)

### Multi-step prompting
* Explicitly tell model what to do by steps

