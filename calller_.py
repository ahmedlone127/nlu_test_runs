import os 
os.system("python3.6 nlu_training_multi_class_text_classifier_demo_hotel_reviews.py --file 'tripadvisor_hotel_reviews.csv' --text 'text' --y_col 'y' --iloc '500' --datatype 'classifier' --embed 'en.embed_sentence.small_bert_L2_128'")
os.system("python3.6 nlu_training_multi_class_text_classifier_demo_hotel_reviews.py --file 'tripadvisor_hotel_reviews.csv' --text 'text' --y_col 'y' --iloc '500' --datatype 'classifier' --embed 'en.embed_sentence.small_bert_L4_128'")
os.system("python3.6 nlu_training_multi_class_text_classifier_demo_hotel_reviews.py --file 'tripadvisor_hotel_reviews.csv' --text 'text' --y_col 'y' --iloc '500' --datatype 'classifier' --embed 'en.embed_sentence.small_bert_L6_128'")


