import { collection, getDocs } from 'firebase/firestore';
import { db } from '../../../firebase';
import { useEffect, useState } from 'react';
import CardStay from '../../cardOfStay/CardStay';
import styles from './Stays.module.scss';
import Sidebar from '../../sidebar/Sidebar';
import Header from '../../Header';

function Stays() {
  const [stays, setStays] = useState([]);

  const getData = async () => {
    let items = [];
    await getDocs(collection(db, 'hotel')).then((querySnapshot) => {
      querySnapshot.docs.map((doc) => items.push(doc.data()));
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
        <div className={styles.stays}>
          {stays.map((item) => {
            return <CardStay data={item} />;
          })}
        </div>
      </main>
    </>
  );
}

export default Stays;
