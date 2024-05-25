import clsx from 'clsx';
import styles from './CardStay.module.scss';

function CardStay({ data }) {
  function numberWithCommas(x) {
    var parts = x.toString().split('.');
    parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, '.');
    return parts.join(',');
  }
  var bg = data.rate > 9 ? 'blue' : 'yellow';

  return (
    <div className={styles.cardStay}>
      {/* image */}
      <div className={styles.image}>
        <img src={data.img} />
      </div>

      {/* information */}
      <div className={styles.infor}>
        <p className={styles.name}>{data.name}</p>
        <div className={styles.rate}>
          <span className={clsx(styles.point, bg)} style={{ marginRight: '10px' }}>{data.rate}</span>
          <span>
            {data.rate > 9 ? 'Tuyệt vời' : data.rate > 8 ? 'Rất tốt' : 'Tốt'}
          </span>
        </div>
        <p className={styles.price}>VND {numberWithCommas(data.oldprice)}</p>
        <div>
          <span>Địa chỉ: </span>
          <span className={styles.address}>{data.detail_placed}</span>
        </div>
      </div>
    </div>
  );
}

export default CardStay;
