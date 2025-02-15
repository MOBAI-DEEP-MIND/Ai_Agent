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
    temperature=0,
    max_tokens=None,
    timeout=None,
    max_retries=2,
)

import json
import re

def format_response(response_text):
    """
    Extracts and formats a valid JSON response from a given text response.
    
    Args:
        response_text (str): The raw text response containing JSON.
    
    Returns:
        list | dict: A list of formatted book entries if successful, or an error dictionary if parsing fails.
    """
    try:
        # Remove Markdown code blocks (```json and ```)
        response_text = response_text
        cleaned_text = re.sub(r"```json|```", "", response_text).strip()

        # Load as JSON
        formatted_data = json.loads(cleaned_text)

        if isinstance(formatted_data, list):
            return formatted_data  # Return as a list of dictionaries
        else:
            return {"error": "Unexpected JSON structure"}
    
    except json.JSONDecodeError:
        return {"error": "Invalid JSON format"}



def generate_response(query, context_point,tool_name="def"):
    """Generate a refined query prompt based on the provided context, ensuring all book fields are included."""
    
    # # Ensure context is a string
    # if isinstance(context, list):
    #     context = "\n".join(str(item) for item in context)
    payload_texts = [item.dict()["payload"]["text"] for item in context_point]

    print("payload_texts",payload_texts)
    prompt = f"""
    Given the following context, identify books that satisfy the criteria of the query.

    Context:
    {payload_texts}

    Query:
    "{query}"

    Instructions:
    - Retrieve books strictly related to the query from the provided context.
    - Ensure that the response includes all relevant book fields in the following structured format:
      ```json
      [
        {{
          "title": "(Book title)",
          "author": "(Author's name)",
          "publication Year": (Year of publication or null if unknown),
          "genre": "(Book genre)",
          "description": "(A short summary of the book)"
        }}
      ]
      ```
    - If the query is vague, infer the best possible meaning based on the context.

    Provide a **valid JSON response** that includes all book details in the expected format.
    """

    response = llm.invoke(prompt)
    print(payload_texts)
    if tool_name == "perform_search":

        # Ensure the response is a string (extracting the actual content)
        if hasattr(response, "content"):
            print("response",response.content)
            return format_response(response.content)  # Extract text content as-is
        
        return {"error": "Invalid response format"}  # Fallback if response is not as expected
    
    elif tool_name=="perform_purchase":

        form = format_response(response.content)
        prompt_2 = f"""
            you have a list of json book could you give me 
            {form}

            could you give me the title of a book in the first json object if available give me only the title
        """

        res = llm.invoke(prompt_2)

        return res.content 