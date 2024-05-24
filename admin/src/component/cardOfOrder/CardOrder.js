import styles from './CardOrder.module.scss';

function CardOrder({ data }) {
  return (
    <tr>
      <td>{data.name}</td>
      <td>{data.startday}</td>
      <td>{data.enday}</td>
      <td>{data.time}</td>
      <td>{data.number}</td>
      <td>{data.totalDays}</td>
      <td>{data.totalPrice}</td>
      <td>
        <button className={styles.btnDelete}>Delete</button>
      </td>
    </tr>
  );
}

export default CardOrder;
