package dao.impl;

import java.lang.reflect.ParameterizedType;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import dao.IBaseDao;

public class BaseDao<T> implements IBaseDao<T>{

	protected SessionFactory sessionFactory;
	private Class<T> clazz;
	
	public BaseDao(){
		ParameterizedType pt =(ParameterizedType) this.getClass().getGenericSuperclass();
		this.clazz = (Class) pt.getActualTypeArguments()[0];
	}

	
	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@Override
	public void add(T entity) {
		Session session=this.sessionFactory.openSession();
		session.beginTransaction();
		session.save(entity);
		session.getTransaction().commit();
		session.close();
	}

	@Override
	public void delete(T entity) {
		Session session=this.sessionFactory.openSession();
		session.beginTransaction();
		session.delete(entity);
		session.getTransaction().commit();
		session.close();
		
	}

	@Override
	public void update(T entity) {
		Session session=this.sessionFactory.openSession();
		session.beginTransaction();
		session.merge(entity);
		session.getTransaction().commit();
		session.close();
		
	}

	@Override
	public T findById(String id) {
		Session session=this.sessionFactory.openSession();
		T et=(T)session.get(clazz,id);
		session.close();
		return et;
	}

	@Override
	public T findById(Long id) {
		Session session=this.sessionFactory.openSession();
		T et=(T)session.get(clazz,id);
		session.close();
		return et;
	}

	@Override
	public List<T> findAll() {
		Session session=this.sessionFactory.openSession();
		List l=session.createQuery(
                "FROM "+clazz.getSimpleName())
                .list();
		session.close();
		return l;
	}
	
}
