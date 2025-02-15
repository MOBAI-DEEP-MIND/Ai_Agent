from core.models import *
from .serializers import *
from rest_framework.generics import ListCreateAPIView,RetrieveUpdateDestroyAPIView,CreateAPIView, RetrieveAPIView  ,ListAPIView  
from rest_framework.permissions import AllowAny,IsAdminUser,IsAuthenticated
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .serializers import PurchaseSerializer,BookSerializer
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.authentication import JWTAuthentication
from core.models import CustomUser
from agents.agent import handle_query,perform_recommendations
import random


class BookAdminListView(ListCreateAPIView):
    """Admin can list and create books"""
    queryset = Book.objects.all()
    serializer_class = BookSerializer
    permission_classes = [IsAdminUser]
    authentication_classes = [JWTAuthentication]

class BookAdminDetailView(RetrieveUpdateDestroyAPIView):
    """Admin can retrieve, update, or delete a book"""
    queryset = Book.objects.all()
    serializer_class = BookSerializer
    permission_classes = [IsAdminUser]
    authentication_classes = [JWTAuthentication]

class BookView(ListAPIView):
    """Get a list of books"""
    queryset = Book.objects.all()
    serializer_class = BookSerializer
    permission_classes = [IsAuthenticated]
    authentication_classes = [JWTAuthentication]

    def get_queryset(self):
        return Book.objects.order_by("title")[:25]  
    
class BookDetailView(RetrieveAPIView):
    """Retrieve a specific book"""
    queryset = Book.objects.all()
    serializer_class = BookSerializer
    permission_classes = [IsAuthenticated]
    authentication_classes = [JWTAuthentication]


class CategoryView(ListCreateAPIView,RetrieveUpdateDestroyAPIView):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    permission_classes = [IsAuthenticated]    


class AuthorView(ListCreateAPIView,RetrieveUpdateDestroyAPIView):
    queryset = Author.objects.all()
    serializer_class = AuthorSerializer
    permission_classes = [IsAdminUser]     


class PurchaseView(APIView):
    serializer_class = PurchaseSerializer
    permission_classes = [IsAuthenticated]

    def post(self,request):
        serializer = PurchaseSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save(user=request.user)
            return Response(serializer.data,status=status.HTTP_201_CREATED)
        return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)
    

class QueryView(CreateAPIView):
    serializer_class = BookSearchSerializer
    permission_classes = [IsAuthenticated]
    authentication_classes = [JWTAuthentication]

    def create(self, request, *args, **kwargs):
        query = request.data.get("query")
        response = handle_query(query,kwargs={"user":request.user})
        print("res",response) 
        return Response(response, status=status.HTTP_200_OK)
    
 

class BookDetailView(RetrieveAPIView,ListAPIView):
    """get the query of the search and return the result of the search"""

    queryset = Book.objects.all()
    serializer_class = BookSerializer
    permission_classes = [IsAuthenticated]
    authentication_classes = [JWTAuthentication]




class PurchaseView(APIView):
    serializer_class = PurchaseSerializer
    permission_classes = [IsAuthenticated]
    authentication_classes = [JWTAuthentication]

    def post(self,request):
        serializer = PurchaseSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save(user=request.user,price=random.randint(1,100))
            return Response(serializer.data,status=status.HTTP_201_CREATED)
        return Response(serializer.errors,status=status.HTTP_400_BAD_REQUEST)
    




class CreditCardView (CreateAPIView):
    """Perform a purchase of a book for a user."""
    serializer_class = PurchaseSerializer
    permission_classes = [IsAuthenticated]
    authentication_classes = [JWTAuthentication]
    
    def post(self, request, *args, **kwargs):
        user = request.user
        book_id = request.data.get("book_id")
        number_books = request.data.get("number_books")
        credit_card_number = request.data.get("credit_card_number")
        cvv = request.data.get("cvv")
        expiration_date = request.data.get("expiration_date")
        book = Book.objects.get(id=book_id)
        purchase_data = {"user": user.id, "book": book.id, "number_books": number_books, "credit_card_number": credit_card_number, "cvv": cvv, "expiration_date": expiration_date}
        serializer = PurchaseSerializer(data=purchase_data)
        
        if serializer.is_valid():
            serializer.save()
            return Response({
                "status": "success",
                "message": "Purchase completed successfully.",
                "data": serializer.data
            }, status=status.HTTP_200_OK)
        else:
            return Response({
                "status": "error",
                "message": "Invalid purchase data.",
                "errors": serializer.errors
            }, status=status.HTTP_400_BAD_REQUEST)
        




class BookRecommendationView(ListAPIView):
    serializer_class = BookSerializer
    permission_classes = [IsAuthenticated]
    authentication_classes = [JWTAuthentication]

    def get_queryset(self):
        user = self.request.user
        user_search_history = History.objects.filter(user=user)
        book_ids = user_search_history.values_list('books', flat=True)
        books = Book.objects.filter(id__in=book_ids)
        return books

    def list(self, request, *args, **kwargs):
        queryset = self.get_queryset() # get the history books of the user
        result = perform_recommendations.invoke(input=queryset)
        return Response({"data":result}, status=status.HTTP_200_OK)





# class BusketView(APIView):
#     serializer_class = BookSerializer
#     permission_classes = [IsAuthenticated]
#     authentication_classes = [JWTAuthentication]
    
#     def get(self,request):
#         queryset = Book.objects.all().filter(user=self.request.user)