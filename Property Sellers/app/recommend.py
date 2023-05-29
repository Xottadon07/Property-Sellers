# import numpy as np
# import pandas as pd
# from sklearn.feature_extraction.text import CountVectorizer


# movies = pd.read_csv('2020-4-27.csv')
# movies = movies[['Title','Address','City','Price','Bedroom','Bathroom','Floors','Parking','Amenities']]
# movies.isnull().sum()
# movies.dropna(inplace=True)
# movies.isnull().sum()
# movies.duplicated().sum()
# movies.iloc[0].Amenities
# movies.iloc[0].Address
# movies['Address'].apply(lambda x:x.split())
# movies['Address'] = movies['Address'].apply(lambda x:x.split())
# movies['Address'].apply(lambda x:[i.replace(",","") for i in x])
# movies['Amenities'] = movies['Amenities'].apply(lambda x:x.split())

# movies['Amenities'] = movies['Amenities'].apply(lambda x:[i.replace("'","") for i in x])
# movies['Amenities'] = movies['Amenities'].apply(lambda x:[i.replace("[","") for i in x])
# movies['Amenities'] = movies['Amenities'].apply(lambda x:[i.replace("]","") for i in x])
# movies['Amenities'] = movies['Amenities'].apply(lambda x:[i.replace(",","") for i in x])
# movies['Amenities'] = movies['Amenities'].apply(lambda x:[i.replace(" ","") for i in x])

# movies['Tags'] = movies['Address'] + movies['Amenities']

# new_df = movies[['Title','Tags']]
# new_df['Tags'] = new_df['Tags'].apply(lambda x:" ".join(x))
# new_df['Tags'] = new_df['Tags'].apply(lambda x:x.lower())


# cv = CountVectorizer(max_features=150)

# cv.fit_transform(new_df['Tags']).toarray()
# vectors = cv.fit_transform(new_df['Tags']).toarray()


import pickle
import pandas as pd

movie_dict = pickle.load(open('recomendation_dict.pkl', 'rb'))
movies = pd.DataFrame(movie_dict)

similarity = pickle.load(open('similarity.pkl', 'rb'))


def recommend(movie):
    print('movie')
    movie_index = movies[movies['Title'] == movie].index[0]
    distances = similarity[movie_index]
    movie_list = sorted(list(enumerate(distances)),
                        reverse=True, key=lambda x: x[1])[1:6]

    recommended_movies = []
    for i in movie_list:
        recommended_movies.append(movies.iloc[i[0]].Title)
    return recommended_movies
