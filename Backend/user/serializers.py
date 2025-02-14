from core.models import CustomUser
from rest_framework import serializers
from django.contrib.auth import get_user_model
from random import randint

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ('id', 'email', 'username','password','credit')
        extra_kwargs = {'password': {'write_only': True},'credit': {'read_only': True}}

    def create(self, validated_data):
        """Create a new user with encrypted password and return it"""
        return get_user_model().objects.create_user(**validated_data,credit=randint(100, 22000))
    