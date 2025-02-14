from dotenv import load_dotenv
from langchain_google_genai import ChatGoogleGenerativeAI
import os
import json
import re

# Load the .env file
load_dotenv()

# Now get the API key
GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")

llm = ChatGoogleGenerativeAI(
    model="gemini-1.5-pro",
    api_key=GEMINI_API_KEY,
    max_tokens=None,
    timeout=None,
    max_retries=3, # Number of retries if the request fails
    temperature=0.3
)


def transform_string_to_json(input_string):
    # Split the input string into individual book entries
    book_entries = input_string.strip().split('\n"')

    # Initialize a list to store the parsed books
    books = []

    # Iterate through each book entry
    for entry in book_entries:
        # Initialize a dictionary to store the current book's data
        book_data = {}

        # Split the entry into lines
        lines = entry.strip().split('\n')

        # Extract fields from each line
        for line in lines:
            if line.startswith("title : "):
                book_data["title"] = line.replace("title : ", "").strip()
            elif line.startswith("author : "):
                book_data["author"] = line.replace("author : ", "").strip()
            elif line.startswith("category : "):
                book_data["category"] = line.replace("category : ", "").strip()
            elif line.startswith("description : "):
                book_data["description"] = line.replace("description : ", "").strip()

        # Add the book data to the list
        if book_data:  # Ensure the dictionary is not empty
            books.append(book_data)

    # Convert the list of books to JSON
    return json.dumps(books, indent=4)





def clean_response(data):
    """Clean and format the LLM JSON response."""
    
    # Remove triple backticks and "json" keyword if present
    cleaned_data = re.sub(r"```json|```", "", data).strip()
    
    # Remove unnecessary newlines and extra spaces
    cleaned_data = re.sub(r"\n\s*", "", cleaned_data)
    
    # Convert to valid JSON
    try:
        books = json.loads(cleaned_data)
        return books  # Return as a list of dictionaries
    except json.JSONDecodeError:
        return {"error": "Invalid JSON format"}


def generate_response(query, context, tool_name):
    """Generate a refined query prompt based on the provided context, ensuring all book fields are included."""
    
    # Ensure context is a string
    if isinstance(context, list):
        context = "\n".join(str(item) for item in context)

    if tool_name == "perform_search":
        # Format for search tool
        prompt = f"""
        Given the following context, identify books that satisfy the criteria of the query.

        Context:
        {transform_string_to_json(context)}

        Query:
        "{query}"

        Instructions:
        - Retrieve books strictly related to the query from the provided context.
        - Ensure that the response includes all relevant book fields in the following structured format:
          ```json
          [
            {{
              "Title": "(Book title)",
              "Author": "(Author's name)",
              "Publication Year": (Year of publication or null if unknown),
              "Genre": "(Book genre)",
              "Description": "(A short summary of the book)"
            }}
          ]
          ```
        - If the query is vague, infer the best possible meaning based on the context.

        Provide a **valid JSON response** that includes all book details in the expected format.
        """
    elif tool_name == "perform_purchase":
        # Improved prompt to select a book if no explicit title is given
        prompt = f"""
        Given the following context, identify the most relevant book that matches the query.
        
        Context:
        {transform_string_to_json(context)}
        
        Query:
        "{query}"
        
        Instructions:
        - If a book title in the context matches the query exactly, return that title.
        - If no exact match is found, return the title of the most relevant book based on the context.
        - If no book in the context is relevant, return "Unknown".
        - Output format: "<book title>", nothing else.

        - If the query is vague, infer the best possible meaning based on the context.
            """

    else:
        return {"error": "Invalid tool name"}

    # Invoke the LLM with the prompt
    response = llm.invoke(prompt)
    print(context)
    # Ensure the response is a string (extracting the actual content)
    if hasattr(response, "content"):
        if tool_name == "perform_search":
            return clean_response(response.content)  # Clean and format JSON for search
        
        elif tool_name == "perform_purchase":
            # Extract title using regex
            match = re.search(r'"(.*?)"', response.content)
            if match:
                return match.group(1)  # Return only the book title
            else:
                return "Unknown"  # Fallback if no title is found
    
    return {"error": "Invalid response format"}  # Fallback if response is not as expected
