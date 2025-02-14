from django.urls import path

from .views import BookView, PurchaseView, QueryView, BookDetailView, AuthorView, CategoryView, BookAdminListView

from .views import PurchaseView,BookDetailView, BookAdminDetailView, BookRecommendationView

urlpatterns = [
    path('book/',BookView.as_view(),name='book'),
    path('book/<int:pk>/',BookDetailView.as_view(),name='book'),
    path('bookAdmin/',BookAdminListView.as_view(),name='bookadmin'),
    path('bookAdmin/<int:pk>/',BookAdminDetailView.as_view(),name='bookadmin'),
    path('authors/',AuthorView.as_view(),name='author'),
    path('authors/<int:pk>/',AuthorView.as_view(),name='author'),
    path('categories/',CategoryView.as_view(),name='category'),
    path('categories/<int:pk>',CategoryView.as_view(),name='category'),
    path('purchase/',PurchaseView.as_view(),name='purchase'),
    path('query/',QueryView.as_view(),name='search'),
    path('books/<int:pk>/',BookDetailView.as_view(),name='book'),
    path('book-recommendation/',BookRecommendationView.as_view(),name='book-recommendation'),
]


