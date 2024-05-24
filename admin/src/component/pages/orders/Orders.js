import { collection, getDocs } from 'firebase/firestore';
import { db } from '../../../firebase';
import { useEffect, useState } from 'react';

import styles from './Orders.module.scss';
import Sidebar from '../../sidebar/Sidebar';
import Header from '../../Header';
import CardOrder from '../../cardOfOrder/CardOrder';

function Orders() {
  const [orders, setOrders] = useState([]);

  const getData = async () => {
    let items = [];
    await getDocs(collection(db, 'booking')).then((querySnapshot) => {
      querySnapshot.docs.map((doc) => items.push(doc.data()));
    });

    setOrders(items);
  };

  useEffect(() => {
    getData();
  }, []);

  return (
    <>
      <Sidebar />
      <Header />
      <main>
        <table className={styles.orders}>
          <tr>
            <th>Name</th>
            <th>Startday</th>
            <th>Enday</th>
            <th>Time</th>
            <th>Number</th>
            <th>Total Days</th>
            <th>Total Price</th>
            <th></th>
          </tr>
          {orders.map((item) => {
            return <CardOrder data={item} />;
          })}
        </table>
      </main>
    </>
  );
}

export default Orders;
