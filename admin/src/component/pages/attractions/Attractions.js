import { collection, getDocs } from 'firebase/firestore';
import { db } from '../../../firebase';
import { useEffect, useState } from 'react';

import styles from './Attractions.module.scss';
import Sidebar from '../../sidebar/Sidebar';
import Header from '../../Header';
import CardAttractions from '../../cardOfAttractions/CardAttractions';

function Attractions() {
  const [stays, setStays] = useState([]);

  const getData = async () => {
    let items = [];
    await getDocs(collection(db, 'Placed')).then((querySnapshot) => {
      querySnapshot.docs.map((doc) => {
        items.push(doc.data());
      });
    });

    setStays(items);
  };

  useEffect(() => {
    getData();
  }, []);

  return (
    <>
      <Sidebar />
      <Header />
      <main>
        <div className={styles.attractions}>
          {stays.map((item) => {
            return <CardAttractions data={item} />;
          })}
        </div>
      </main>
    </>
  );
}

export default Attractions;
