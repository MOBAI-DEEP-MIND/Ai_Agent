from langchain_core.tools import tool
from langchain.chains import LLMChain
from langchain.prompts import PromptTemplate
from core.models import Purchase, Book
from book.serializers import BusketSerializer, BookSerializer
from .llm import generate_response  # Assuming this is your LLM interaction function
from .embeddings import main  # Assuming this is your embedding function
from agents.llm import llm  # Assuming this is your LLM instance




@tool
def perform_purchase(query, **kwargs) -> dict:
    """Perform a purchase of a book for a user."""
    try:
        # books = perform_search(query) 
        context_data = main(query) 
        res = generate_response(query, context_data,tool_name="perform_purchase")
        print("res purshase",res)
        
        try:
            number_books = 1 # Default to 1 book
        except ValueError:
            return {
                "status": "error",
                "message": "Invalid response from LLM: expected a number."
            }

        # books = books[:number_books]
        busket = {
            "user": kwargs['kwargs']['user'],
            # "book": books
        }
        print("result of search",res)
        serializer = BusketSerializer(data=busket)
        if serializer.is_valid():
            serializer.save()
            return {
                "status": "success",
                "message": "Book added to busket."
            }
        else:
            return {
                "status": "error",
                "message": f"def{serializer.errors}"
            }

    except Exception as e:
        return {
            "status": "error",
            "message": str(e)
        }


@tool
def perform_search(query: str):
    """Perform a search for books based on a query."""
    try:
        context_data = main(query)
        res = generate_response(query, context_data,tool_name="perform_search")
        print("llm reponse",res)
        return res
    except Exception as e:
        return {
            "status": "error",
            "message": str(e)
        }



@tool
def perform_recommendations(user_search_history, books_df):
    """Generate book recommendations based on a user's search history."""
    history_text = "\n".join([f"User {row['id_user']} searched for Book {row['idbook']}" for row in user_search_history.iterrows()])


    prompt = f"""
    Given the following user search history:
    {history_text}

    Recommend books that this user would likely enjoy. Consider the user's preferences from their search history.
    Here is the book information:
    {books_df[['id_book', 'title', 'genre', 'description']].to_string(index=False)}

    Provide book recommendations, with a brief explanation for each.
    """

    try:
        context_data = main(prompt)
        response = generate_response(prompt, context_data)
        recommendations = response.choices[0].text.strip()
    except Exception as e:
        return {
            "status": "error",
            "message": f"Error interacting with Gemini: {str(e)}"
        }

    return recommendations



def determine_tool(query: str) -> str:
    """Determine which tool to use based on the user's query."""
    purchase_keywords = ["buy", "purchase", "order", "get book"]
    search_keywords = ["search", "find", "look for", "book about"]

    if any(keyword in query.lower() for keyword in purchase_keywords):
        return "perform_purchase"
    elif any(keyword in query.lower() for keyword in search_keywords):
        return "perform_search"
    else:
        return None


def handle_query(query: str, **kwargs) -> dict:
    """Handle the user query using Langchain chains."""
    
    tool_name = determine_tool(query)
    prompt_template = """Refine the following user query for a book search: {query}"""  
    prompt = PromptTemplate(input_variables=["query"], template=prompt_template)

    llm_chain = LLMChain(llm=llm, prompt=prompt)  
    refined_query = llm_chain.run(query) 
    
    if tool_name == "perform_purchase":
        user_id = kwargs['kwargs']['user'].id
        if user_id is None:
            return {
                "status": "error",
                "message": "Missing user_id for purchase."
            }
        return perform_purchase.invoke(input=refined_query,kwargs={"user_id": user_id})



    elif tool_name == "perform_search":
 
        print(f"Refined Query: {query}")
        return perform_search.invoke(input=refined_query)  

    else:
        return {
            "status": "error",
            "message": "Could not determine the appropriate action for your query."
        }


# # Example usage
# user_query = "I want to buy a book about AI"
# response = handle_query(user_query, user_id=1)
# print(response)

# user_query = "Find books about Python programming"
# response = handle_query(user_query)
# print(response)

# user_query = "I'm looking for a book about deep learning"
# response = handle_query(user_query)
# print(response)