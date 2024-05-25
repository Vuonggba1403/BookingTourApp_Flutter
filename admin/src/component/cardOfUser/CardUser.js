import styles from './CardUser.module.scss';

function CardUser({ data }) {
  return (
    <tr>
      <td>{data.email}</td>
      <td>{data.name}</td>
      <td>{data.password}</td>
      <td>
        <button className={styles.btnDelete}>Delete</button>
        <button className={styles.btnEdit}>Edit</button>
      </td>
    </tr>
  );
}

export default CardUser;
