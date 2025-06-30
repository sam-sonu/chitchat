import pandas as pd
from sqlalchemy import create_engine, DateTime, VARCHAR, Text, Integer  # Added Text and Integer
from urllib.parse import quote_plus
import sys
from datetime import datetime


def round_to_two_hours(hours):
    """Round up to 2 hours if duration is less than 2 hours"""
    return 2 if hours < 2 else hours


def main():
    
    try:
        # 1. Load TXT file
        file_path = r"C:/Users/sonu.km/Desktop/basefile/sql_py_reader_bot/cataloouge/text_10data.txt"
        df = pd.read_csv(
            file_path,
            sep='\t',
            engine='python',
            header=0,
            dtype=str
        )
        print(f"✅ File loaded successfully. Rows: {len(df)}")

        # 2. Data transformation
        
        base_url = 'https://samsungu.csod.com/ui/lms-learning-details/app/course/'
        
        df = df.assign(ref_link=base_url + df['Course ID'].astype(str))
        df = df.rename(columns={
            'Course Name': 'title',
            'Classification': 'description',
            'Training Hours' : 'duration',
            'Course ID' : 'course_id'
        })
        
        # Add required columns with default values
        df['del_yn'] = 'N'  
        df['status_cd'] = 'status.draft'
        df['type_cd'] = ''
        df['code'] = ''
        df['sno'] = 0 
        df['obj_cd'] = 'content.course.module'
        df['modifier_id'] = 61  # Assuming system user
        df['creator_id'] = 61   # Assuming system user
        df['pid'] = 4054          # Default parent ID
        df['parent_id'] = 4054    # Default parent ID
        df['author_id'] = 0    # Default creator ID
        df['duration'] = df['duration'].astype(float).apply(round_to_two_hours)
        df['create_dt'] = pd.to_datetime(datetime.now())
        df['modify_dt'] = pd.to_datetime(datetime.now())
        

        # 3. Database connection
        mysql_password = "DBpoum0&8"
        password = quote_plus(mysql_password)
        
        engine = create_engine(
            f"mysql+pymysql://root:{password}@107.109.40.131:3306/gh_v3_prd",
            pool_recycle=3600,
            pool_pre_ping=True,
            connect_args={
                'connect_timeout': 5
            }
        )

        # 4. Verify connection
        with engine.connect() as conn:
            print("✅ Database connection verified")
            
        # 5. Data validation
        print("\nData validation:")
        print(f"Unique UUIDs: {df['ref_link'].nunique()}/{len(df)}")
        print(f"Null values:\n{df.isnull().sum()}")

        # Update SQL type mapping
        # Updated dtype mapping
        dtype_map = {
            'modify_dt': DateTime(),
            'create_dt': DateTime(),
            'ref_link': VARCHAR(300),
            'title': VARCHAR(300),
            'description': Text(),  
            'code': VARCHAR(100),
            'sno': Integer(),      
            'del_yn': VARCHAR(1),
            'status_cd': VARCHAR(200),
            'type_cd': VARCHAR(200),
            'obj_cd': VARCHAR(50),
            'duration': Integer(),  
            'course_id': VARCHAR(300)
        }
        df = df[[
            'title', 'ref_link', 'description', 'sno',
            'del_yn', 'modifier_id', 'modify_dt', 'creator_id',
            'create_dt', 'code', 'status_cd', 'type_cd', 'obj_cd',
            'pid', 'parent_id', 'author_id' ,'course_id', 'duration'
        ]]
        # 7. Insert data
        df.to_sql(
            name='content_course_module',
            con=engine,
            if_exists='append',
            index=False,
            dtype=dtype_map,
            chunksize=100
        )
        
        print(f"\n✅ Successfully inserted {len(df)} records")

    except Exception as e:
        print(f"\n❌ Error: {str(e)}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()