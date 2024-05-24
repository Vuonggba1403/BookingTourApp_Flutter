import { collection, getDocs } from 'firebase/firestore';
import { db } from '../../../firebase';
import { useEffect, useState } from 'react';

import styles from './Users.module.scss';
import Sidebar from '../../sidebar/Sidebar';
import Header from '../../Header';
import CardUser from '../../cardOfUser/CardUser';

function Users() {
  const [users, setUsers] = useState([]);

  const getData = async () => {
    let items = [];
    await getDocs(collection(db, 'users')).then((querySnapshot) => {
      querySnapshot.docs.map((doc) => items.push(doc.data()));
    });

    setUsers(items);
  };

  useEffect(() => {
    getData();
  }, []);

  return (
    <>
      <Sidebar />
      <Header />
      <main>
        <table className={styles.users}>
          <tr>
            <th>Email</th>
            <th>Name</th>
            <th>Password</th>
            <th colSpan={2}></th>
          </tr>
          {users.map((item) => {
            return <CardUser data={item} />;
          })}
        </table>
      </main>
    </>
  );
}

export default Users;
