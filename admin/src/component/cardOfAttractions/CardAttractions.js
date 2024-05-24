import styles from './CardAttractions.module.scss';

function CardAttractions({ data }) {

  return (
    <div className={styles.cardStay}>
      {/* image */}
      <div className={styles.image}>
        <img src={data.img} />
      </div>

      {/* information */}
      <div className={styles.infor}>
        <p className={styles.name}>{data.placed}</p>
        <p className={styles.price}>VND {data.money}</p>
        <div>
          <span>Description: </span>
          <span className={styles.des}>{data.des}</span>
        </div>
      </div>
    </div>
  );
}

export default CardAttractions;
